Deface::Override.new(
  virtual_path: "spree/admin/users/_form",
  name: "referral_settings",
  insert_after: "[data-hook='admin_user_form_password_fields']",
  partial: "spree/admin/users/referral_settings"
)
