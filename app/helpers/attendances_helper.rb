<% provide(:title, @user.name) %>
<%= form_with(model: @user, url: attendances_update_one_month_user_path(date: @first_day), local: true, method: :patch) do |f| %>
  <div>
    <h1>勤怠編集画面</h1>
    <table class="table table-bordered table-condensed table-hover" id="table-attendances">
      <thead>
        <tr>
          <th>日付</th>
          <th>曜日</th>
          <th>出勤時間</th>
          <th>退勤時間</th>
          <th>在社時間</th>
          <th>備考</th>
        </tr>
      </thead>
      <tbody>
        <% @attendances.each do |day| %>
          <%= f.fields_for "attendances[]", day do |attendance| %>
            <tr>
              <td><%= l(day.worked_on, format: :short) %></td>
              <td><%= $days_of_the_week[day.worked_on.wday] %></td>
              <td><%= attendance.time_field :started_at, class: "form-control" %></td>
              <td><%= attendance.time_field :finished_at, class: "form-control" %></td>
              <td>
                <% if day.started_at.present? && day.finished_at.present? %>
                  <%= working_times(day.started_at, day.finished_at) %>
                <% end %>
              </td>
              <td><%= attendance.text_field :note, class: "form-control" %></td>
            </tr>
          <% end %>
        <% end %>
      </tbody>
    </table>
  </div>

  <div class="center">
    <%= f.submit "まとめて更新", class: "btn btn-lg btn-primary" %>
    <%= link_to "キャンセル", user_path(date: @first_day), class: "btn btn-lg btn-default" %>
  </div>
<% end %>