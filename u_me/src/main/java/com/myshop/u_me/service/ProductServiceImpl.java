package com.myshop.u_me.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.u_me.dao.ProductDao;
import com.myshop.u_me.vo.ProductVo;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
    private ProductDao productDao;

	@Override
	public List<ProductVo> getProductByCategory(int categoryId) {
		return productDao.getProductsByCategory(categoryId);
	}
	
	@Override
	public String getCategoryNameById(int categoryId) {
		return productDao.getCategoryName(categoryId);
	}

	@Override
	public ProductVo getProductByProductId(int productId) {
		List<ProductVo> productDetailVos = productDao.getProductsByProductId(productId);
	    // Check if the list is not empty and return the first element
	    if (productDetailVos != null && !productDetailVos.isEmpty()) {
	        
	    	ProductVo productVo = productDetailVos.get(0);
	    	String description = productVo.getDescription().replaceAll("\n", "<br>");
	    	
	    	productVo.setDescription(description);
	    	
	    	return productVo;
	    }

	    // Return an empty ProductVo if the list is empty or null
	    return new ProductVo();
	    
	    
	}
	
	@Override
	public List<String> getAllImgByProductId(int productId) {
		return productDao.getAllImg(productId);
	}


	@Override
	public List<ProductVo> getCart() {
		System.out.println("getCart()");
		
		return productDao.selectAll();
	}

	@Override
	public int getTotalPriceByProductId() {
		return productDao.getTotalPrice();
	}

	@Override
	public void removeProduct(int[] productIds) {
	    productDao.deleteProducts(productIds);
	}

	public void removeAll() {
		productDao.removeAll();
		
	}

	public List<ProductVo> orderItem(int[] productIds) {
		return productDao.orderProducts(productIds);
		
	}

	


	
}
