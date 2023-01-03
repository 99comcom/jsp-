package model;

public class OrderVO {
	
	private String order_id;
	private String prod_id;
	private int price;
	private int qnt;
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQnt() {
		return qnt;
	}
	public void setQnt(int qnt) {
		this.qnt = qnt;
	}
	@Override
	public String toString() {
		return "OrderVO [order_id=" + order_id + ", prod_id=" + prod_id + ", price=" + price + ", qnt=" + qnt + "]";
	}
	
	
	

}
