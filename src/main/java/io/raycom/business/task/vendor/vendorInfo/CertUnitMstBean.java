package io.raycom.business.task.vendor.vendorInfo;


import io.raycom.context.bean.MsgBean;
import io.raycom.core.collection.RData;


/**
 * 资质单元主bean
 */
public class CertUnitMstBean  implements MsgBean{
    
	private String vendorId;
    private String orgId;
	private String companyType;
    private String status;
    private String companyName;
    private String applyMstId;
    
    
	public String getVendorId() {
		return vendorId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
    
	public String getApplyMstId() {
		return applyMstId;
	}

	public void setApplyMstId(String applyMstId) {
		this.applyMstId = applyMstId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	@Override
	public void init(RData arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public RData toRData() {
		// TODO Auto-generated method stub
		RData rdata = new RData();
		rdata.set("vendorId",this.getVendorId());
        rdata.set("status",this.getStatus());
        rdata.set("companyType",this.getCompanyType());
        rdata.set("orgId", this.getOrgId());
        rdata.set("companyName", this.getCompanyName());
        rdata.set("applyMstId", this.getApplyMstId());
		return rdata;
	}
	
}