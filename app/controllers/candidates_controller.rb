class CandidatesController < ApplicationController
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

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email, :telephone, :linkedin, :twitter)
  end
end
