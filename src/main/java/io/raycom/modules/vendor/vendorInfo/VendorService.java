package io.raycom.modules.vendor.vendorInfo;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.service.BaseService;

@Service
@Transactional
public class VendorService extends BaseService {
	
	@Autowired
	private VendorDao vendorDao;

	public void queryVendorList(Page<RData> page) {
		page.setData(vendorDao.queryVendorList(page));
	}

	public RData queryVh(RData rdata) {
		RData vhData = vendorDao.queryVh(rdata);
		return vhData;
	}

	public ArrayList<RData> queryVhCert(RData rdata) {
		return vendorDao.queryVhCert(rdata);
	}
	
	
}
