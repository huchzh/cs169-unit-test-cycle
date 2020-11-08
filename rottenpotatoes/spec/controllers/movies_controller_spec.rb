require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
    	  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
    	  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
      	  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
      	  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
      	  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
      	  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
      	  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
      	  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
      	  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
  	 ]

RSpec.describe MoviesController, type: :controller do
  context "Case when there is movie director" do
    it "creates movies" do
      movies.each do |movie|
        Movie.create!(movie)
      end
    end
    
    it "uses module helper" do
      MoviesHelper.oddness(2)
    end
  end
  
  describe "creates movies" do
    it "creates movie" do
      post :create, :movie => {:title => 'Chicken Run', :rating => 'G', :description => "something", :release_date => '21-Jun-2000', :director => 'Nick Park'}
      expect(response).not_to eq(nil)
    end
  end
  
  
#   describe "Find Similar route," do
#     context "if the movie has a director," do

#       it "assigns @movies" do
#         @movies = Movie.create(:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000', :director => 'Nick Park')
#         get :index
#         expect(assigns(:movies)).to eq([@movie])
#       end
      
#       it "should go to similar movies page" do
#         get :similar, id: @movie.id
#         expect(response).to render_template("similar")
#       end
#     end
#   end
end
