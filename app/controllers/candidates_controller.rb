# coding: utf-8
class CandidatesController < ApplicationController

  before_action :candidate_id, only: [:show, :edit, :update, :destroy, :vote]
                               
  def index
    @candidates = Candidate.all
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to candidates_path, notice: "The candidate has been successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: "The candidate has been successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "The candidate has been successfully delete."
  end

  def vote
    @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate 
    redirect_to candidates_path, notice: "完成投票!"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end
end

  def candidate_id
    @candidate ||= Candidate.find_by(id: params[:id])
  end
