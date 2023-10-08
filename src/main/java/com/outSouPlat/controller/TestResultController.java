package com.outSouPlat.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.outSouPlat.service.*;
import com.outSouPlat.util.*;

@Controller
@RequestMapping("/testResult")
public class TestResultController {

	@Autowired
	private TestResultService testResultService;
	public static final String MODULE_NAME="testResult";
	
	@RequestMapping(value="/synthetic/list")
	public String goSyntheticList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/synthetic/list";
	}
}
