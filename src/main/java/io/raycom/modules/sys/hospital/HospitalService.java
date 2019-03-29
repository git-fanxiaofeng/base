package io.raycom.modules.sys.hospital;

import io.raycom.web.service.BaseService;
import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 医院基本信息管理
 * @author 孙莉然
 * @version 2016-04-11
 */
@Service
@Transactional(readOnly = true)
public class HospitalService extends BaseService{
	
	@Autowired
	private HospitalDao hospitalDao;

	public void queryHospitalList(Page<RData> page){
		ArrayList<RData> rList = hospitalDao.queryHospitalList(page);
		page.setData(rList);
	}
	
	public void createHospital(RData rData){
		hospitalDao.createHospital(rData);
	}
	
	public RData queryHospitalDetial(RData rData){
		return hospitalDao.queryHospitalDetail(rData);
	}
	
	public void updateHospital(RData rdata) {
		hospitalDao.updateHospital(rdata);
	}
}
