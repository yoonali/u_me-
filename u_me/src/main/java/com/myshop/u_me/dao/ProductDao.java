package com.myshop.u_me.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.myshop.u_me.vo.CartVo;
import com.myshop.u_me.vo.ProductVo;
import com.myshop.u_me.vo.UserVo;

@Component
public class ProductDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	HttpSession session;
	
	public List<ProductVo> getProductsByCategory(int categoryId) {
		
		String sql = "SELECT p.* FROM product p JOIN category c ON p.category_id = c.id WHERE p.category_id = ?";
			
		 List<ProductVo> productVos;
		 
		 try {
			 
			 productVos = jdbcTemplate.query(sql, new RowMapper<ProductVo>() {
				 
				 @Override
				 public ProductVo mapRow(ResultSet rs, int rowNum) throws 
				 SQLException {
					ProductVo productVo = new ProductVo();
					 
					productVo.setCategory_id(rs.getInt("category_id"));
                    productVo.setName(rs.getString("name"));
                    productVo.setPrice(rs.getInt("price"));
                    productVo.setStoke(rs.getInt("stoke"));
                    productVo.setImg(rs.getString("img"));
                    productVo.setDescription(rs.getString("description"));
                    
                    return productVo;
				 }
			 }, categoryId);
		 }catch (Exception e) {
			 e.printStackTrace();
			 return null;
		 }
		 
		 return productVos;
		
		
	}
	
	public String getCategoryName(int categoryId) {
        String sql = "SELECT name FROM category WHERE id = ?"; 

        String categoryName = jdbcTemplate.queryForObject(sql, String.class, categoryId);

        return categoryName;
    }
	
	
	public List<ProductVo> getProductsByProductId(int productId) {
		
		String sql = "SELECT * FROM product WHERE id = ?";
		
		
		try {
			return jdbcTemplate.query(sql, new RowMapper<ProductVo>() {
				 
				 @Override
				 public ProductVo mapRow(ResultSet rs, int rowNum) throws 
				 SQLException {
					ProductVo productVo = new ProductVo();
					 
					productVo.setCategory_id(rs.getInt("category_id"));
                    productVo.setName(rs.getString("name"));
                    productVo.setPrice(rs.getInt("price"));
                    productVo.setStoke(rs.getInt("stoke"));
                    productVo.setDescription(rs.getString("description"));
                   
                   return productVo;
				 }
			 }, productId);
		 }catch (Exception e) {
			 e.printStackTrace();
			 return null;
		 }
		 
	}
	
	public List<String> getAllImg(int productId) {
		
		String sql = "SELECT url FROM img WHERE product_id = ?";
		
		try {
	        List<String> imgUrls = jdbcTemplate.queryForList(sql, String.class, productId);

	        // 가져온 이미지 URL 리스트를 반환
	        return imgUrls;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public List<ProductVo> selectAll() {
		System.out.println("selectAll()");
		
		UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
		
		if(loginedUserVo != null) {
			String sql = "SELECT *, cart.quantity AS quantity FROM product JOIN cart ON product.id = cart.product_id WHERE cart.user_id = ?";
			
			List<ProductVo> cart = new ArrayList<ProductVo>();
			
			try {
				cart = jdbcTemplate.query(sql, new Object[]{loginedUserVo.getId()} ,new RowMapper<ProductVo>() {
					
					@Override
					public ProductVo mapRow(ResultSet rs, int rowNum) throws
					SQLException {
						
						ProductVo productVo = new ProductVo();
						
						productVo.setId(rs.getInt("id"));
						productVo.setName(rs.getString("name"));
						productVo.setImg(rs.getString("img"));
						productVo.setPrice(rs.getInt("price"));
						productVo.setQuantity(rs.getInt("quantity"));
						
						return productVo;
					}
				}); 
			}catch (Exception e) {
				e.printStackTrace();
			}
			return cart.size() > 0 ? cart : null;
		}else {
			return null;
		}
	}
	
	public int getTotalPrice() {
	    UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
	    CartVo getCartVo = (CartVo) session.getAttribute("getCartVo");

	    if (loginedUserVo != null && getCartVo != null) {
	        String sql = "SELECT SUM(quantity * price) FROM product JOIN cart ON product.id = cart.product_id WHERE cart.user_id = ?";
	        
	        try {
	            int total = jdbcTemplate.queryForObject(sql, new Object[]{loginedUserVo.getId()}, Integer.class);
	            return total;
	        } catch (NullPointerException e) {
	            // Handle the exception or log it
	            e.printStackTrace();
	            return 0;
	        }
	    } else {
	        return 0;
	    }
	}

	public void deleteProducts(int[] productIds) {
	    UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");

	    if (loginedUserVo != null) {
	        String sql = "DELETE FROM cart WHERE user_id = ? AND product_id IN ("
	                + String.join(",", Collections.nCopies(productIds.length, "?")) + ")";

	        jdbcTemplate.update(connection -> {
	            PreparedStatement preparedStatement = connection.prepareStatement(sql);
	            preparedStatement.setInt(1, loginedUserVo.getId());

	            for (int i = 0; i < productIds.length; i++) {
	                preparedStatement.setInt(i + 2, productIds[i]);
	            }

	            return preparedStatement;
	        });
	    }
	}


	public void removeAll() {
		
		UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
		
		if(loginedUserVo != null) {
			 String sql = "DELETE FROM cart WHERE user_id = ?";
	        jdbcTemplate.update(sql, loginedUserVo.getId());
		}
	}

	public List<ProductVo> orderProducts(int[] productIds) {
	    UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
	    List<ProductVo> orderedProducts = new ArrayList<>();

	    if (loginedUserVo != null) {
	        String sql = "SELECT * FROM product JOIN cart ON product.id = cart.product_id WHERE cart.user_id = ? AND cart.product_id IN ("
	                + String.join(",", Collections.nCopies(productIds.length, "?")) + ")";

	        orderedProducts = jdbcTemplate.query(sql, (rs, rowNum) -> {
	            ProductVo productVo = new ProductVo();

	            productVo.setId(rs.getInt("id"));
	            productVo.setName(rs.getString("name"));
	            productVo.setImg(rs.getString("img"));
	            productVo.setPrice(rs.getInt("price"));
	            productVo.setQuantity(rs.getInt("quantity"));

	            return productVo;
	        }, loginedUserVo.getId(), productIds);
	    }

	    return orderedProducts.size() > 0 ? orderedProducts : null;
	}


	private void processOrder(List<ProductVo> orderedProducts) {
	   
	}
	



}
