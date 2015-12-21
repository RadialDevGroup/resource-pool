class CandidatesController < ApplicationController

  def index
    @candidates = Candidate.all
  end

  def show
    @candidate = Candidate.find(params[:id])
  end
  
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new candidate_params

    if @candidate.save
      redirect_to root_path, notice: "Candidate created successfully"
    else
      flash[:alert] = @candidate.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.attributes = candidate_params

    if @candidate.save
      redirect_to root_path, notice: "Candidate updated successfully"
    else
      flash[:alert] = @candidate.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email, :telephone, :linkedin, :twitter, :referral_source)
  end
end
