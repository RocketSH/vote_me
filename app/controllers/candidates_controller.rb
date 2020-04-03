class CandidatesController < ApplicationController

    def index
      @candidates = Candidate.all
    end

    def show
     @candidate = Candidate.find_by(id: params[:id])
    end

    def new
      @candidate = Candidate.new
    end
    
    def create
      @candidate = Candidate.new(candidate_params)

      if @candidate.save
        flash[:notice] = "The candidate has been successfully created."
        redirect_to candidates_path 
      else
        render :new
      end
    end

    def edit
      @candidate = Candidate.find_by(id: params[:id])
    end

    def update
      @candidate = Candidate.find_by(id: params[:id])

      if @candidate.update(candidate_params)
        flash[:notice] = "The candidate has been successfully updated."
        redirect_to candidates_path 
      else
        render :edit
      end
    end

    def destroy
      @candidate = Candidate.find_by(id: params[:id])
      @candidate.destroy if @candidate
      redirect_to candidates_path, notice: "The candidate has been successfully delete."
    end

    private
    def candidate_params
      params.require(:candidate).permit(:name, :age, :party, :politics)
    end
end
