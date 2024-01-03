package com.myshop.u_me.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.myshop.u_me.service.CartService;
import com.myshop.u_me.service.ProductServiceImpl;
import com.myshop.u_me.vo.CartVo;
import com.myshop.u_me.vo.ProductVo;

@Controller
public class ShopController {

	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);

	@Autowired
	ProductServiceImpl productService;

	@Autowired
	CartService cartService;

	@GetMapping("/category")
	public String Category(@RequestParam("categoryId") int categoryId, Model model) {
		System.out.println("Category()");

		String nextPage = "shop/category";

		List<ProductVo> productVos = productService.getProductByCategory(categoryId);
		String categoryName = productService.getCategoryNameById(categoryId);

		model.addAttribute("ProductVos", productVos);
		model.addAttribute("categoryName", categoryName);

		return nextPage;
	}

	@GetMapping("/product")
	public String Product(@RequestParam("productId") int productId, Model model) {
		System.out.println("Product()");

		String nextPage = "shop/product";

		ProductVo productDetailVo = productService.getProductByProductId(productId);
		List<String> getAllImg = productService.getAllImgByProductId(productId);

		model.addAttribute("productDetailVo", productDetailVo);
		model.addAttribute("Imgs", getAllImg);

		System.out.println(nextPage);

		return nextPage;
	}

	@PostMapping("/inCart")
	public String putProductInCart(CartVo cartVo) {
		System.out.println("putProductInCart");
		System.out.println(cartVo.getUser_id());

		String nextPage = "redirect:/cart";

		int result = cartService.addToCart(cartVo);

		if (result < 0)
			nextPage = "home";

		return nextPage;
	}

	@GetMapping("/cart")
	public String cart(Model model, HttpSession session) {
		System.out.println("cart()");

		String nextPage = "shop/cart";

		List<ProductVo> productVos = productService.getCart();

		CartVo getCartVo = cartService.getCartVo();
		System.out.println("test");

		int total = productService.getTotalPriceByProductId();

		model.addAttribute("ProductVos", productVos);
		model.addAttribute("total", total);

		session.setAttribute("getCartVo", getCartVo);

		return nextPage;
	}

	@GetMapping("/remove_item")
	public String removeSelectedItems(@RequestParam("productId") int[] productIds) {
		String nextPage = "redirect:/cart";

		productService.removeProduct(productIds);

		return nextPage;
	}
	
	@GetMapping("/remove_order_item")
	public String removeOrderSelectedItems(@RequestParam("productId") int[] productIds) {
		String nextPage = "redirect:/order";

		productService.removeProduct(productIds);

		return nextPage;
	}

	@GetMapping("/remove_all")
	public String removeAll() {
		String nextPage = "redirect:/cart";

		productService.removeAll();

		return nextPage;
	}

	  
	  @GetMapping("/order") 
	  public String order(Model model) {
		  
		  String nextPage = "shop/order";
		  
		  int total = productService.getTotalPriceByProductId();
		  
		  List<ProductVo> orderProductVos = productService.getCart();
		  
		  model.addAttribute("orderProductVos", orderProductVos);
		  model.addAttribute("total", total);
		  
		  return nextPage;
	  }
	  
	  
		
	  @GetMapping("/order_item") 
	  public String orderSelectedItem(@RequestParam("productId") int[] productIds) {
	  
	  String nextPage = "redirect:/order";
	  
	  List<ProductVo> orderProductVos = productService.orderItem(productIds); 
	  
	  return nextPage;
	  }
	
	  
	  /*
		 * @PostMapping("/order_f") public String orderFinsh() {
		 * 
		 * }
		 */
	 
}
