package com.myshop.u_me.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.u_me.dao.CartDao;
import com.myshop.u_me.vo.CartVo;
import com.myshop.u_me.vo.UserVo;

@Service
public class CartService {
	
	final static public int CART_IN_SUCCESS = 1;
	final static public int CART_IN_FAIL= -1;
	final static public int CART_ALRAEDY_EXIST = 0;

	@Autowired
	CartDao cartDao;
	
	@Autowired
	HttpSession session;
	
	public int addToCart(CartVo cartVo) {
        System.out.println("addToCart()");

        boolean isCartIn = cartDao.addToCart(cartVo.getProduct_id());

        if (!isCartIn) {
            int result = cartDao.insertProduct(cartVo);

            if (result > 0)
                return CART_IN_SUCCESS;
            else
                return CART_IN_FAIL;
        } else {

            UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
            
            CartVo getCartVo = (CartVo) session.getAttribute("getCartVo"); 
            
            if(loginedUserVo != null && getCartVo != null && loginedUserVo.getId() == getCartVo.getUser_id()) {
            	int result = cartDao.updateQuantity(cartVo.getProduct_id());
            	if (result > 0)
                    return CART_ALRAEDY_EXIST;
                else
                    return CART_IN_FAIL;
            }else {
            	int result = cartDao.insertProduct(cartVo);
            	 if (result > 0)
                     return CART_IN_SUCCESS;
                 else
                     return CART_IN_FAIL;
            }
        }
    }

	public CartVo getCartVo() {
		System.out.println("getCartVo()");
		
		return cartDao.selectAll();
	}


}
