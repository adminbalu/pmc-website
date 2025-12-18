-- Hotel Renovation Control Center schema (Postgres/Supabase-ready)

create table if not exists rooms (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name text not null,
  capacity integer default 0,
  go_live date not null,
  created_at timestamptz default now()
);

create table if not exists workstreams (
  id uuid primary key default gen_random_uuid(),
  room_id uuid references rooms(id) on delete cascade,
  title text not null,
  owner text not null,
  status text not null default 'Not Started',
  start_date date,
  end_date date,
  progress numeric default 0,
  risk_level text default 'low',
  created_at timestamptz default now()
);

create index if not exists workstreams_room_idx on workstreams(room_id);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  workstream_id uuid references workstreams(id) on delete cascade,
  name text not null,
  phase text,
  start_date date,
  end_date date,
  assignee text,
  status text not null default 'todo',
  progress numeric default 0,
  comments text,
  hiccups text,
  created_at timestamptz default now()
);

create index if not exists tasks_workstream_idx on tasks(workstream_id);

create table if not exists task_updates (
  id uuid primary key default gen_random_uuid(),
  task_id uuid references tasks(id) on delete cascade,
  update_type text not null default 'comment',
  body text,
  percent_complete numeric,
  created_by text,
  created_at timestamptz default now()
);

create index if not exists task_updates_task_idx on task_updates(task_id);

create table if not exists daily_reports (
  id uuid primary key default gen_random_uuid(),
  report_date date not null,
  morning_summary text,
  evening_summary text,
  blockers text,
  created_at timestamptz default now()
);

create unique index if not exists daily_reports_date_idx on daily_reports(report_date);

-- Sample view powering WhatsApp digests
create or replace view v_daily_digest as
select
  dr.report_date,
  json_agg(
    json_build_object(
      'workstream', ws.title,
      'status', ws.status,
      'progress', ws.progress,
      'tasks_due_today', (
        select json_agg(name)
        from tasks t
        where t.workstream_id = ws.id
          and t.start_date <= dr.report_date
          and t.end_date >= dr.report_date
      )
    )
    order by ws.title
  ) as workstreams
from daily_reports dr
left join workstreams ws on ws.start_date <= dr.report_date and (ws.end_date is null or ws.end_date >= dr.report_date)
group by dr.report_date;


