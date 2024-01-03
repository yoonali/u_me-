package com.myshop.u_me.service;

import java.util.List;

import com.myshop.u_me.vo.ProductVo;

public interface ProductService {
	List<ProductVo> getProductByCategory(int categoryId);
	
	String getCategoryNameById(int categoryId);
	
	ProductVo getProductByProductId(int productId);
	
	List<String> getAllImgByProductId(int productId);
	
	List<ProductVo> getCart();
	
	int getTotalPriceByProductId();
	
	void removeProduct(int[] productIds);
}
