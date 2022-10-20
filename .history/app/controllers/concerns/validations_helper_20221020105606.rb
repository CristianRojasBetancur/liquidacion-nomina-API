module ValidationsHelper
  extend ActiveSupport::Concern

  private

  def have_company?
    if @current_user.company.nil?
      render json: {error: {
        code: "030",
        message: "You haven't a company registered",
        object: "Period"
      }}, status: 404
    end
  end

  def have_workers?
    if @current_user.company.workers == []
      render json: {error: {
        code: "029",
        message: "You don't have employees",
        object: "Modifications"
      }}, status: 404
    end
  end
end