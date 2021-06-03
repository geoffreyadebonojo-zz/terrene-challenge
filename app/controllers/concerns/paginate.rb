module Paginate
  def paginate(object, args=nil)
    return object if args.nil?
    
    page = args[:page] || 1
    results_per_page = args[:results_per_page] || object.count
    object.page(page).per(results_per_page)
  end
end
