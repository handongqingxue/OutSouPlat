package com.outSouPlat.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projMana")
public class ProjManaController {

	public static final String MODULE_NAME="projMana";
	
	@RequestMapping(value="/projList/list")
	public String goProjListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/projList/list";
	}
}
