package com.myshop.u_me.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myshop.u_me.service.UserService;
import com.myshop.u_me.vo.AddressVo;
import com.myshop.u_me.vo.UserVo;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	UserService userService;
	
	@GetMapping("/signup")
	public String signUp(Locale locale, Model model) {
			
		return "member/signup";
	}
	
	@PostMapping("/signup_ng")
	public String join(RedirectAttributes redirectAttributes, UserVo userVo) throws UnsupportedEncodingException {
		logger.info("Controller join()");
		
		String nextPage = "member/signup";
		
		int result = userService.join(userVo);
		
		if(result == UserService.ADMIN_ACCOUNT_CREATE_SUCCESS) {

			redirectAttributes.addAttribute("user_id", userVo.getUser_id());
		    redirectAttributes.addAttribute("name", userVo.getName());

			nextPage = "redirect:/confirm/" + java.net.URLEncoder.encode(userVo.getUser_id(), "UTF-8") + "/"
			        + java.net.URLEncoder.encode(userVo.getName(), "UTF-8"); // Confirm 페이지로 리다이렉트
		}
		else if(result == UserService.ADMIN_ACCOUNT_CREATE_FAIL)
			nextPage = "member/signup";
		
	   return nextPage;


	}
	
	@GetMapping("/confirm/{user_id}/{name}")
	public String confirm(@PathVariable("user_id") String userId, @PathVariable("name") String name, Model model) {
	    try {
	        // URL decode to handle special characters
	        name = java.net.URLDecoder.decode(name, "UTF-8");
	    } catch (UnsupportedEncodingException e) {
	        // Handle the exception
	        e.printStackTrace();
	    }
	    model.addAttribute("user_id", userId);
	    model.addAttribute("name", name);
	    return "member/confirm";
	}


	@GetMapping("/login")
	public String login() {
		System.out.println("login()");
		
		String nextPage = "member/login";
		
		return nextPage;
	}
	
	@PostMapping("/loginConfirm")
	public String loginConfirm(UserVo userVo, HttpSession session) {
		System.out.println("memberController loginConfirm()");
		
		String nextPage = "home";
		
		UserVo loginedUserVo = userService.loginConfirm(userVo);
		
		if(loginedUserVo == null) {
			nextPage = "member/login";
		}else {
			session.setAttribute("loginedUserVo", loginedUserVo);
			session.setMaxInactiveInterval(60 * 30); //30분으로 설정 (초 단위)
		}

		return nextPage;
	}
	
	@GetMapping("/logoutConfirm")
	public String logoutConfirm(HttpSession session, Model model) {
	    System.out.println("logoutConfirm()");

	    //세션 무효화
	    session.invalidate();

	    model.addAttribute("logoutMessage", "로그아웃 되었습니다!");

	    return "redirect:/home";
	}

	
	@PostMapping("/addr_in")
	public String putAddress(AddressVo addressVo, UserVo userVo) {
		System.out.println("putAddress()");
		
		String nextPage = "redirect:/mypage";
		
		int result = userService.addAddress(addressVo);
		
		int userResult = userService.updateUserInfo(userVo);
		
		if(result <= 0 && userResult <= 0)
			nextPage = "home";
		
		return nextPage;
	}
	
	@GetMapping("/mypage")
	public String address(Model model, HttpSession session) {
		String nextPage = "member/mypage";
		
		AddressVo addressVos = userService.getAddress();
		
		model.addAttribute("addressVos", addressVos);
		
		session.setAttribute("addressVos", addressVos);
		
		return nextPage;
	}
}
