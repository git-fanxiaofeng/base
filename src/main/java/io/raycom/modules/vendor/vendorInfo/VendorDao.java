package io.raycom.modules.vendor.vendorInfo;

import java.util.ArrayList;

import io.raycom.core.collection.RData;
import io.raycom.web.bean.Page;
import io.raycom.web.persistence.annotation.MyBatisDao;


@MyBatisDao
public interface VendorDao {

	public ArrayList<RData> queryVendorList(Page<RData> page);

	public RData queryVh(RData rdata);

	public ArrayList<RData> queryVhCert(RData rdata);

}
