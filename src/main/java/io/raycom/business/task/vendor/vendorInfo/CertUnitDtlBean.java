package io.raycom.business.task.vendor.vendorInfo;


import io.raycom.context.bean.MsgBean;
import io.raycom.core.collection.RData;


/**
 * 资质单元子bean
 */
public class CertUnitDtlBean  implements MsgBean{
    
	private String applyCertificateId;
	private String applyMstId;
	private String applyDtlId;
	private String vendorId;
    private String orgId;
    private String agencyOrder;
    
    
	public String getApplyCertificateId() {
		return applyCertificateId;
	}

	public void setApplyCertificateId(String applyCertificateId) {
		this.applyCertificateId = applyCertificateId;
	}
    
	public String getApplyMstId() {
		return applyMstId;
	}

	public void setApplyMstId(String applyMstId) {
		this.applyMstId = applyMstId;
	}

	public String getApplyDtlId() {
		return applyDtlId;
	}

	public void setApplyDtlId(String applyDtlId) {
		this.applyDtlId = applyDtlId;
	}

	public String getVendorId() {
		return vendorId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getAgencyOrder() {
		return agencyOrder;
	}

	public void setAgencyOrder(String agencyOrder) {
		this.agencyOrder = agencyOrder;
	}

	@Override
	public void init(RData arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public RData toRData() {
		// TODO Auto-generated method stub
		RData rdata = new RData();
		rdata.set("applyCertificateId",this.getApplyCertificateId());
		rdata.set("applyMstId", this.getApplyMstId());
		rdata.set("applyDtlId", this.getApplyDtlId());
		rdata.set("vendorId",this.getVendorId());
        rdata.set("orgId", this.getOrgId());
        rdata.set("agencyOrder",this.getAgencyOrder());
		return rdata;
	}
	
}