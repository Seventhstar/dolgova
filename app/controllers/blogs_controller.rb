class BlogsController < InheritedResources::Base

  private

    def blog_params
      params.require(:blog).permit(:title, :description)
    end

end
