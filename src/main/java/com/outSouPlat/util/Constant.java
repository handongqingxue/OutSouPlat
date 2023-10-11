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
	
	/**
	 * 存放用户权限常量
	 * @param request
	 */
	public static void setUserPermissionInRequest(HttpServletRequest request) {

		request.setAttribute("projAddPerm", Permission.PROJ_ADD);//1
		request.setAttribute("projDelPerm", Permission.PROJ_DEL);//2
		request.setAttribute("projEditPerm", Permission.PROJ_EDIT);//3
		request.setAttribute("projSearPerm", Permission.PROJ_SEAR);//4
		
		request.setAttribute("taskBagAddPerm", Permission.TASK_BAG_ADD);//5
		request.setAttribute("taskBagDelPerm", Permission.TASK_BAG_DEL);//6
		request.setAttribute("taskBagEditPerm", Permission.TASK_BAG_EDIT);//7
		request.setAttribute("taskBagSearPerm", Permission.TASK_BAG_SEAR);//8
		request.setAttribute("taskBagSubmitPerm", Permission.TASK_BAG_SUBMIT);//21
		request.setAttribute("taskBagOrderPerm", Permission.TASK_BAG_ORDER);//22
		
		request.setAttribute("taskOrderAddPerm", Permission.TASK_ORDER_ADD);//9
		request.setAttribute("taskOrderDelPerm", Permission.TASK_ORDER_DEL);//10
		request.setAttribute("taskOrderEditPerm", Permission.TASK_ORDER_EDIT);//11
		request.setAttribute("taskOrderSearPerm", Permission.TASK_ORDER_SEAR);//12
		request.setAttribute("uploadCodePerm", Permission.UPLOAD_CODE);//23
		request.setAttribute("uploadTestResultPerm", Permission.UPLOAD_TEST_RESULT);//24
		
		request.setAttribute("testResultAddPerm", Permission.TEST_RESULT_ADD);//13
		request.setAttribute("testResultDelPerm", Permission.TEST_RESULT_DEL);//14
		request.setAttribute("testResultEditPerm", Permission.TEST_RESULT_EDIT);//15
		request.setAttribute("testResultSearPerm", Permission.TEST_RESULT_SEAR);//16
		
		request.setAttribute("userSearPerm", Permission.USER_SEAR);//17
		request.setAttribute("userEditPerm", Permission.USER_EDIT);//18
		request.setAttribute("userCheckPerm", Permission.USER_CHECK);//19
		request.setAttribute("unCheckUserSearPerm", Permission.UN_CHECK_USER_SEAR);//20
		
		/*
		request.setAttribute("xgshdwQx", QuanXian.XIU_GAI_SHOU_HUO_DAN_WEI);//25
		request.setAttribute("scshdwQx", QuanXian.SHAN_CHU_SHOU_HUO_DAN_WEI);//26
		request.setAttribute("tjckQx", QuanXian.TIAN_JIA_CANG_KU);//27
		request.setAttribute("ddztcxQx", QuanXian.DING_DAN_ZHUANG_TAI_CHA_XUN);//28
		request.setAttribute("cxbdjlQx", QuanXian.CHA_XUN_BANG_DAN_JI_LU);//29
		request.setAttribute("cxgbjlQx", QuanXian.CHA_XUN_GUO_BANG_JI_LU);//30
		request.setAttribute("cxwzlxQx", QuanXian.CHA_XUN_WU_ZI_LEI_XING);//31
		request.setAttribute("cxwzQx", QuanXian.CHA_XUN_WU_ZI);//32
		request.setAttribute("cxyssQx", QuanXian.CHA_XUN_YUN_SHU_SHANG);//33
		request.setAttribute("cxfhdwQx", QuanXian.CHA_XUN_FA_HUO_DAN_WEI);//34
		request.setAttribute("cxshdwQx", QuanXian.CHA_XUN_SHOU_HUO_DAN_WEI);//35
		request.setAttribute("cxckQx", QuanXian.CHA_XUN_CANG_KU);//36
		request.setAttribute("tjclQx", QuanXian.TIAN_JIA_CHE_LIANG);//37
		request.setAttribute("xgclQx", QuanXian.XIU_GAI_CHE_LIANG);//38
		request.setAttribute("scclQx", QuanXian.SHAN_CHU_CHE_LIANG);//39
		request.setAttribute("cxclQx", QuanXian.CHA_XUN_CHE_LIANG);//40
		request.setAttribute("shclQx", QuanXian.SHEN_HE_CHE_LIANG);//41
		request.setAttribute("cxcltzQx", QuanXian.CHA_XUN_CHE_LIANG_TAI_ZHANG);//42
		request.setAttribute("cxclshjlQx", QuanXian.CHA_XUN_CHE_LIANG_SHEN_HE_JI_LU);//43
		request.setAttribute("tjsjQx", QuanXian.TIAN_JIA_SI_JI);//44
		request.setAttribute("xgsjQx", QuanXian.XIU_GAI_SI_JI);//45
		request.setAttribute("scsjQx", QuanXian.SHAN_CHU_SI_JI);//46
		request.setAttribute("cxsjQx", QuanXian.CHA_XUN_SI_JI);//47
		request.setAttribute("shsjQx", QuanXian.SHEN_HE_SI_JI);//48
		request.setAttribute("cxsjshjlQx", QuanXian.CHA_XUN_SI_JI_SHEN_HE_JI_LU);//49
		request.setAttribute("cxpdhmQx", QuanXian.CHA_XUN_PAI_DUI_HAO_MA);//50
		request.setAttribute("scpdhmQx", QuanXian.SHAN_CHU_PAI_DUI_HAO_MA);//51
		request.setAttribute("tjdlQx", QuanXian.TIAN_JIA_DUI_LIE);//52
		request.setAttribute("xgdlQx", QuanXian.XIU_GAI_DUI_LIE);//53
		request.setAttribute("scdlQx", QuanXian.SHAN_CHU_DUI_LIE);//54
		request.setAttribute("cxdlQx", QuanXian.CHA_XUN_DUI_LIE);//55
		request.setAttribute("cxyhQx", QuanXian.CHA_XUN_YONG_HU);//56
		request.setAttribute("xgyhQx", QuanXian.XIU_GAI_YONG_HU);//57
		request.setAttribute("shyhQx", QuanXian.SHEN_HE_YONG_HU);//58
		request.setAttribute("cxyhshjlQx", QuanXian.CHA_XUN_YONG_HU_SHEN_HE_JI_LU);//59
		request.setAttribute("tjjsQx", QuanXian.TIAN_JIA_JUE_SE);//60
		request.setAttribute("xgjsQx", QuanXian.XIU_GAI_JUE_SE);//61
		request.setAttribute("scjsQx", QuanXian.SHAN_CHU_JUE_SE);//62
		request.setAttribute("cxjsQx", QuanXian.CHA_XUN_JUE_SE);//63
		request.setAttribute("rgsbsfzQx", QuanXian.REN_GONG_SHI_BIE_SHEN_FEN_ZHENG);//64
		request.setAttribute("rgsbcpQx", QuanXian.REN_GONG_SHI_BIE_CHE_PAI);//65
		request.setAttribute("rgsbewmQx", QuanXian.REN_GONG_SHI_BIE_ER_WEI_MA);//66
		request.setAttribute("ddfwQx", QuanXian.DING_DAN_FU_WEI);//67
		request.setAttribute("bddyQx", QuanXian.BANG_DAN_DA_YIN);//68
		request.setAttribute("cxddshjlQx", QuanXian.CHA_XUN_DING_DAN_SHEN_HE_JI_LU);//69
		request.setAttribute("scddshjlQx", QuanXian.SHAN_CHU_DING_DAN_SHEN_HE_JI_LU);//70
		request.setAttribute("xgckQx", QuanXian.XIU_GAI_CANG_KU);//71
		request.setAttribute("scckQx", QuanXian.SHAN_CHU_CANG_KU);//72
		request.setAttribute("scclshjlQx", QuanXian.SHAN_CHU_CHE_LIANG_SHEN_HE_JI_LU);//73
		request.setAttribute("sccltzQx", QuanXian.SHAN_CHU_CHE_LIANG_TAI_ZHANG);//74
		request.setAttribute("pdhmztcxQx", QuanXian.PAI_DUI_HAO_MA_ZHUANG_TAI_CHA_XUN);//75
		request.setAttribute("scyhshjlQx", QuanXian.SHAN_CHU_YONG_HU_SHEN_HE_JI_LU);//76
		request.setAttribute("qxcxQx", QuanXian.QUAN_XIAN_CHA_XUN);//77
		*/
	}
}
