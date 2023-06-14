package model;

public class Order { 
	String userName;
	int quantity, total, product_id, stock;
	
	public Order() {}
	
	public Order(int quantity, int total, int product_id,int stock, 
			String userName){
		
		this.quantity = quantity;
		this.total = total;
		this.stock = stock;
		this.product_id = product_id;
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}


	
	
}
