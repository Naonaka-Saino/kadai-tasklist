class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end

  def show
   @task=current_user.tasks.find(params[:id])
  end

  def new
      @task = Task.new
  end

#newのページから送信されるフォームを処理する。
  def create
      #これにフォーム中身が入っている。
      @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = '保存したぞ、絶対やれ'
      redirect_to root_url
    else
      
      flash.now[:danger] = '保存されなかったぞ'
      render :new
    end
  end

  def edit
      @task = Task.find(params[:id])
  end
#editのフォームから送信される内容の処理
  def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
      flash[:success] = '編集したぞ、意思の弱いやつめ'
      redirect_to @task
      else
        #これ何？
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = '編集されなかったぞ'
      render :edit
      end
  end

  def destroy
    @task.destroy
    flash[:success] = '消したぞ、意思の弱いやつめ'
    redirect_to tasks_path
  end
  #ストロングパラメータ
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end  
end
