package com.outSouPlat.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.outSouPlat.entity.*;

public class Constant {

	/**
	 * 存放用户审核状态常量
	 * @param request
	 */
	public static void setUserStateInRequest(HttpServletRequest request) {
		
		request.setAttribute("noCheckState", User.NO_CHECK);
		request.setAttribute("checkedState", User.CHECKED);
		request.setAttribute("editingState", User.EDITING);
		
		request.setAttribute("noCheckStateName", User.NO_CHECK_NAME);
		request.setAttribute("checkedStateName", User.CHECKED_NAME);
		request.setAttribute("editingStateName", User.EDITING_NAME);
	}
	
	/**
	 * 存放项目状态常量
	 * @param request
	 */
	public static void setProjectStateInRequest(HttpServletRequest request) {

		request.setAttribute("unContractState", Project.UN_CONTRACT);
		request.setAttribute("contractedState", Project.CONTRACTED);
		request.setAttribute("developingState", Project.DEVELOPING);
		request.setAttribute("finishState", Project.FINISH);
		
		request.setAttribute("unContractStateName", Project.UN_CONTRACT_NAME);
		request.setAttribute("contractedStateName", Project.CONTRACTED_NAME);
		request.setAttribute("developingStateName", Project.DEVELOPING_NAME);
		request.setAttribute("finishStateName", Project.FINISH_NAME);
	}
	
	/**
	 * 存放任务包状态常量
	 * @param request
	 */
	public static void setTaskBagStateInRequest(HttpServletRequest request) {

		request.setAttribute("unSubmitState", TaskBag.UN_SUBMIT);
		request.setAttribute("unOrderState", TaskBag.UN_ORDER);
		request.setAttribute("developingState", TaskBag.DEVELOPING);
		request.setAttribute("testingState", TaskBag.TESTING);
		request.setAttribute("finishState", TaskBag.FINISH);
		
		request.setAttribute("unSubmitStateName", TaskBag.UN_SUBMIT_NAME);
		request.setAttribute("unOrderStateName", TaskBag.UN_ORDER_NAME);
		request.setAttribute("developingStateName", TaskBag.DEVELOPING_NAME);
		request.setAttribute("testingStateName", TaskBag.TESTING_NAME);
		request.setAttribute("finishStateName", TaskBag.FINISH_NAME);
	}
	
	/**
	 * 存放任务单状态常量
	 * @param request
	 */
	public static void setTaskOrderStateInRequest(HttpServletRequest request) {

		request.setAttribute("unFinishState", TaskOrder.UN_FINISH);
		request.setAttribute("finishedState", TaskOrder.FINISHED);
		request.setAttribute("discardedState", TaskOrder.DISCARDED);
		
		request.setAttribute("unFinishStateName", TaskOrder.UN_FINISH_NAME);
		request.setAttribute("finishedStateName", TaskOrder.FINISHED_NAME);
		request.setAttribute("discardedStateName", TaskOrder.DISCARDED_NAME);
	}
	
	/**
	 * 存放测试结果状态常量
	 * @param request
	 */
	public static void setTestResultStateInRequest(HttpServletRequest request) {
		
		request.setAttribute("unTestState", TestResult.UN_TEST);
		request.setAttribute("testingState", TestResult.TESTING);
		request.setAttribute("unPassState", TestResult.UN_PASS);
		request.setAttribute("unPayState", TestResult.UN_PAY);
		request.setAttribute("paidState", TestResult.PAID);
		
		request.setAttribute("unTestStateName", TestResult.UN_TEST_NAME);
		request.setAttribute("testingStateName", TestResult.TESTING_NAME);
		request.setAttribute("unPassStateName", TestResult.UN_PASS_NAME);
		request.setAttribute("unPayStateName", TestResult.UN_PAY_NAME);
		request.setAttribute("paidStateName", TestResult.PAID_NAME);
	}
}
