package io.raycom.business.task.vendor.vendorInfo;


import io.raycom.common.mapper.JsonMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 供应商信息任务类
 */
@Component
public class VendorInfoTask {
	
	@Autowired
	private VendorInfoTaskService vendorInfoTaskService; 
	
	/*
	 * 处理接收到的信息
	 */
	public void vendorMsgReceive(String textMsg){
        //json字符串转为任务bean
		VendorInfoBean vendorInfo = (VendorInfoBean) JsonMapper.fromJsonString(textMsg, VendorInfoBean.class);
		vendorInfoTaskService.manage(vendorInfo);
	}
}

