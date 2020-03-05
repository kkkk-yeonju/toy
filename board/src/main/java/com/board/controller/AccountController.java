package com.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.board.service.MemberService;
import com.board.vo.Member;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;
	
	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String showLoginForm() {
		return "account/login";
	}

	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String login(String id, String pwd, HttpSession session) {

		Member member = memberService.selectMemberByIdAndPasswd(id, pwd);

		if (member != null) {
			session.setAttribute("loginuser", member);
			return "redirect:/";
		} else {
			return "account/login";
		}

	}

	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {

		session.removeAttribute("loginuser");
		return "redirect:/";

	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET) 
	public String showregisterForm() {
		
		return "account/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST) 
	public String register(Member member) {
		
		memberService.insertMember(member);
		
		return "redirect:/account/login";
	}
}
