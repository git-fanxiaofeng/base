package io.raycom.modules.sys.hospital;

import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.persistence.annotation.MyBatisDao;

import java.util.ArrayList;

/**
 * 医院基本信息管理
 * @author 孙莉然
 * @version 2016-04-11
 */
@MyBatisDao
public interface HospitalDao{
		public ArrayList<RData> queryHospitalList(Page<RData> page);
		public void createHospital(RData rdata);
		public RData queryHospitalDetail(RData rdata);
		public void updateHospital(RData rdata);
}


