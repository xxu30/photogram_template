class CommentsController < ApplicationController
  before_action :current_user_must_be_comment_commenter, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_comment_commenter
    comment = Comment.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == comment.commenter
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.comments.ransack(params[:q])
    @comments = @q.result(:distinct => true).includes(:commenter, :photo).page(params[:page]).per(10)

    render("comment_templates/index.html.erb")
  end

  def show
    @comment = Comment.find(params.fetch("id_to_display"))

    render("comment_templates/show.html.erb")
  end

  def new_form
    @comment = Comment.new

    render("comment_templates/new_form.html.erb")
  end

  def create_row
    @comment = Comment.new

    @comment.body = params.fetch("body")
    @comment.commenter_id = params.fetch("commenter_id")
    @comment.photo_id = params.fetch("photo_id")

    if @comment.valid?
      @comment.save

      redirect_back(:fallback_location => "/comments", :notice => "Comment created successfully.")
    else
      render("comment_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_photo
    @comment = Comment.new

    @comment.body = params.fetch("body")
    @comment.commenter_id = params.fetch("commenter_id")
    @comment.photo_id = params.fetch("photo_id")

    if @comment.valid?
      @comment.save

      redirect_to("/photos/#{@comment.photo_id}", notice: "Comment created successfully.")
    else
      render("comment_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @comment = Comment.find(params.fetch("prefill_with_id"))

    render("comment_templates/edit_form.html.erb")
  end

  def update_row
    @comment = Comment.find(params.fetch("id_to_modify"))

    @comment.body = params.fetch("body")
    
    @comment.photo_id = params.fetch("photo_id")

    if @comment.valid?
      @comment.save

      redirect_to("/comments/#{@comment.id}", :notice => "Comment updated successfully.")
    else
      render("comment_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_commenter
    @comment = Comment.find(params.fetch("id_to_remove"))

    @comment.destroy

    redirect_to("/users/#{@comment.commenter_id}", notice: "Comment deleted successfully.")
  end

  def destroy_row_from_photo
    @comment = Comment.find(params.fetch("id_to_remove"))

    @comment.destroy

    redirect_to("/photos/#{@comment.photo_id}", notice: "Comment deleted successfully.")
  end

  def destroy_row
    @comment = Comment.find(params.fetch("id_to_remove"))

    @comment.destroy

    redirect_to("/comments", :notice => "Comment deleted successfully.")
  end
end
