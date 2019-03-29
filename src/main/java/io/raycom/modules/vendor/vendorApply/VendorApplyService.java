package io.raycom.modules.vendor.vendorApply;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.service.BaseService;

@Service
@Transactional
public class VendorApplyService extends BaseService {
	
	@Autowired
	private VendorApplyDao vendorApplyDao;

	public void queryVendorList(Page<RData> page) {
		page.setData(vendorApplyDao.queryVendorList(page));
	}

	public RData queryVh(RData rdata) {
		RData vhData = vendorApplyDao.queryVh(rdata);
		return vhData;
	}

	public ArrayList<RData> queryVhCert(RData rdata) {
		return vendorApplyDao.queryVhCert(rdata);
	}
	
	
}
