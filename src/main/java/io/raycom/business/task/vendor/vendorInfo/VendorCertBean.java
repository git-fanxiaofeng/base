package io.raycom.business.task.vendor.vendorInfo;


import io.raycom.context.bean.MsgBean;
import io.raycom.core.collection.RData;


/**
 * 资质信息bean
 */
public class VendorCertBean  implements MsgBean{
	
	private String applyCertificateId;  
	private String orgId;          
    private String vendorId;       
    private String certificateType;
    private String certificateName;
    private String certificateNo;  
    private String startDate;      
    private String closeDate;      
    private String issueDept;      
    private String attachId;       
    private String manufactureName;
    private String companyName;
    private String certParentCategory;
    private String approveStatus;
    private String approveOption;
    private String approver;
    private String certIden;
    private String authorizedName;

	@Override
	public void init(RData arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public RData toRData() {
		// TODO Auto-generated method stub
		RData rdata = new RData();
		rdata.set("applyCertificateId",this.getApplyCertificateId());
		rdata.set("orgId",this.getOrgId());
		rdata.set("vendorId",this.getVendorId());
		rdata.set("certificateType",this.getCertificateType());
		rdata.set("certificateName",this.getCertificateName());
		rdata.set("certificateNo",this.getCertificateNo());
		rdata.set("startDate",this.getStartDate());
		rdata.set("closeDate",this.getCloseDate());
		rdata.set("issueDept",this.getIssueDept());
		rdata.set("attachId",this.getAttachId());
		rdata.set("manufactureName",this.getManufactureName());
		rdata.set("authorizedName",this.getAuthorizedName());
		rdata.set("companyName",this.getCompanyName());
		rdata.set("certParentCategory",this.getCertParentCategory());
		rdata.set("approveStatus",this.getApproveStatus());
		rdata.set("approveOption",this.getApproveOption());
		rdata.set("approver",this.getApprover());
		rdata.set("certIden",this.getCertIden());
		return rdata;
	}

	public String getApplyCertificateId() {
		return applyCertificateId;
	}

	public void setApplyCertificateId(String applyCertificateId) {
		this.applyCertificateId = applyCertificateId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getVendorId() {
		return vendorId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	public String getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(String certificateType) {
		this.certificateType = certificateType;
	}

	public String getCertificateName() {
		return certificateName;
	}

	public void setCertificateName(String certificateName) {
		this.certificateName = certificateName;
	}

	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

	public String getIssueDept() {
		return issueDept;
	}

	public void setIssueDept(String issueDept) {
		this.issueDept = issueDept;
	}

	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}

	public String getManufactureName() {
		return manufactureName;
	}

	public void setManufactureName(String manufactureName) {
		this.manufactureName = manufactureName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCertParentCategory() {
		return certParentCategory;
	}

	public void setCertParentCategory(String certParentCategory) {
		this.certParentCategory = certParentCategory;
	}

	public String getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}

	public String getApproveOption() {
		return approveOption;
	}

	public void setApproveOption(String approveOption) {
		this.approveOption = approveOption;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getCertIden() {
		return certIden;
	}

	public void setCertIden(String certIden) {
		this.certIden = certIden;
	}

	public String getAuthorizedName() {
		return authorizedName;
	}

	public void setAuthorizedName(String authorizedName) {
		this.authorizedName = authorizedName;
	}
    
}