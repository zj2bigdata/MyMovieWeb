package sun.moviemgr.pojo;

public class Admin {
	private String admin_Id;
	private String admin_Name;
	private String admin_Pwd;
	private String admin_Privilege;
	
	public Admin(){}
	
	
	public Admin(String admin_Id, String admin_Name, String admin_Pwd, String admin_Privilege) {
		this.admin_Id = admin_Id;
		this.admin_Name = admin_Name;
		this.admin_Pwd = admin_Pwd;
		this.admin_Privilege = admin_Privilege;
	}


	public String getAdmin_Id() {
		return admin_Id;
	}


	public void setAdmin_Id(String admin_Id) {
		this.admin_Id = admin_Id;
	}


	public String getAdmin_Name() {
		return admin_Name;
	}


	public void setAdmin_Name(String admin_Name) {
		this.admin_Name = admin_Name;
	}


	public String getAdmin_Pwd() {
		return admin_Pwd;
	}


	public void setAdmin_Pwd(String admin_Pwd) {
		this.admin_Pwd = admin_Pwd;
	}


	public String getAdmin_Privilege() {
		return admin_Privilege;
	}


	public void setAdmin_Privilege(String admin_Privilege) {
		this.admin_Privilege = admin_Privilege;
	}


	
	
	

	
}
