class TasksController < ApplicationController
  def index
        @tasks = Task.all
  end

  def show
      @task = Task.find(params[:id])
  end

  def new
      @task = Task.new
  end

#newのページから送信されるフォームを処理する。
  def create
      #これにフォーム中身が入っている。
      @task = Task.new(task_params)

    if @task.save
      flash[:success] = '保存したぞ、絶対やれ'
      redirect_to @task
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
      flash.now[:danger] = '編集されなかったぞ'
      render :edit
    end

  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = '消したぞ、意思の弱いやつめ'
    redirect_to tasks_url
  end
  #ストロングパラメータ
  def task_params
    params.require(:task).permit(:content)
  end
end
