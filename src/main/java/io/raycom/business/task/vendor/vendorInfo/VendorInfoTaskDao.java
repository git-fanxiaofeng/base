package io.raycom.business.task.vendor.vendorInfo;

import io.raycom.core.collection.RData;
import io.raycom.web.persistence.annotation.MyBatisDao;

@MyBatisDao
public interface VendorInfoTaskDao {

	public void updateVhApply(RData rdata);

	public void updateCertApply(RData rdata);

	public void updateCertUnitMstApply(RData rdata);

	public void updateCertUnitDtlApply(RData rdata);

	public void deleteCertApplyAll(RData rdata);

	public void deleteCertUnitMstApplyAll(RData rdata);

	public void deleteCertUnitDtlApplyAll(RData rdata);

	public int checkVendor(RData vendor);

	public void insertVendor(RData vendor);

	public void insertVendorHis(RData vendor);

	public void insertVendorCert(RData vendor);

	public void insertVh(RData vendor);

	public void insertVendorCertHis(RData vendor);

	public void insertVhCert(RData vendor);

	public void insertCertUnitMst(RData tmp);

	public void insertCertUnitMstHis(RData tmp);

	public void insertVhCertUnitMst(RData tmp);

	public void insertCertUnitDtl(RData tmp);

	public void insertCertUnitDtlHis(RData tmp);

	public void insertVhCertUnitdtl(RData vendor);

	public void updateVendorApply(RData vendor);


}
