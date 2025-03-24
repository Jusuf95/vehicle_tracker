defmodule VehicleTracker.CustomersTest do
  use VehicleTracker.DataCase

  alias VehicleTracker.Customers

  describe "customers" do
    alias VehicleTracker.Customers.Customer

    import VehicleTracker.CustomersFixtures

    @invalid_attrs %{address: nil, first_name: nil, last_name: nil, email: nil, phone: nil, driving_license_number: nil, rental_history: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{address: "some address", first_name: "some first_name", last_name: "some last_name", email: "some email", phone: "some phone", driving_license_number: "some driving_license_number", rental_history: %{}}

      assert {:ok, %Customer{} = customer} = Customers.create_customer(valid_attrs)
      assert customer.address == "some address"
      assert customer.first_name == "some first_name"
      assert customer.last_name == "some last_name"
      assert customer.email == "some email"
      assert customer.phone == "some phone"
      assert customer.driving_license_number == "some driving_license_number"
      assert customer.rental_history == %{}
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", email: "some updated email", phone: "some updated phone", driving_license_number: "some updated driving_license_number", rental_history: %{}}

      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, update_attrs)
      assert customer.address == "some updated address"
      assert customer.first_name == "some updated first_name"
      assert customer.last_name == "some updated last_name"
      assert customer.email == "some updated email"
      assert customer.phone == "some updated phone"
      assert customer.driving_license_number == "some updated driving_license_number"
      assert customer.rental_history == %{}
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
