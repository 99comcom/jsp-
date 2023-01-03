package model;

import java.util.Date;

public class LocalVO {
	private String id;
	private String name;
	private String address;
	private String phone;
	private String keyword;
	private Double x;
	private Double y;
	private Date wdate;
	
	

	
	public Date getWdate() {
		return wdate;
	}



	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public Double getX() {
		return x;
	}



	public void setX(Double x) {
		this.x = x;
	}



	public Double getY() {
		return y;
	}



	public void setY(Double y) {
		this.y = y;
	}



	@Override
	public String toString() {
		return "LocalVO [id=" + id + ", name=" + name + ", adderss=" + address + ", phone=" + phone + ", keyword="
				+ keyword + ", x=" + x + ", y=" + y + "]";
	}

	
	
	
	
}


