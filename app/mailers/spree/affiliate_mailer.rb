module Spree
  class AffiliateMailer < BaseMailer
    def activation_instruction(email)
      @affiliate  = Spree::Affiliate.find_by(email: email)
      subject = Spree.t(:activation_instruction_subject, scope: :affiliate_mailer)
      mail(to: @affiliate.email, from: from_address, subject: subject)
    end

    def confirm_order_email(order)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      current_store = @order.store
      subject = "#{current_store.name} #{Spree.t('order_mailer.confirm_order_email.subject')} ##{@order.number}"
      mail(to: @order.affiliate.email, from: from_address, subject: subject, store_url: current_store.url)
    end
  end
end
