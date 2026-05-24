<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="grid grid-cols-1 lg:grid-cols-12 gap-6">

    <div class="lg:col-span-8 premium-card rounded-2xl p-6 shadow-sm">
        <div class="flex justify-between items-center mb-5">
            <div>
                <h2 class="text-base font-bold text-slate-800">Attendance Overview</h2>
                <p class="text-xs text-slate-400 font-medium">Real-time validation tracking analytics</p>
            </div>
            <button class="px-4 py-1.5 rounded-xl border border-slate-200 bg-slate-50 text-slate-600 font-bold text-xs hover:bg-slate-100 transition-colors">
                This Operational Month
            </button>
        </div>
        <div id="attendanceChartLayout"></div>
    </div>

    <div class="lg:col-span-4 premium-card rounded-2xl p-6 shadow-sm">
        <h2 class="text-base font-bold text-slate-800 mb-1">Department Roster Distribution</h2>
        <p class="text-xs text-slate-400 font-medium mb-5">Headcount allocation breakdown metrics</p>
        <div id="departmentChartLayout"></div>
    </div>

</div>

<script>
// 1. Line Area Data Matrix
var attendanceChartOptions = {
    chart: {
        type: 'area',
        height: 320,
        toolbar: { show: false },
        fontFamily: 'Inter, sans-serif'
    },
    series: [
        { name: 'Present Today', data: [200, 700, 650, 900, 720, 950, 780] },
        { name: 'Absent Account', data: [100, 300, 250, 400, 350, 420, 300] }
    ],
    colors: ['#4f46e5', '#ec4899'],
    stroke: { curve: 'smooth', width: 3 },
    fill: {
        type: 'gradient',
        gradient: { shadeIntensity: 1, opacityFrom: 0.1, opacityTo: 0, stops: [0, 90, 100] }
    },
    grid: { borderColor: '#f1f5f9' },
    xaxis: {
        categories: ['1 May', '8 May', '15 May', '22 May', '29 May'],
        labels: { style: { colors: '#94a3b8', fontWeight: 600 } }
    },
    yaxis: {
        labels: { style: { colors: '#94a3b8', fontWeight: 600 } }
    },
    legend: { labels: { colors: '#475569' } }
};

new ApexCharts(document.querySelector("#attendanceChartLayout"), attendanceChartOptions).render();

// 2. Headcount Allocation Donut Chart Configuration
var departmentChartOptions = {
    chart: {
        type: 'donut',
        height: 320,
        fontFamily: 'Inter, sans-serif'
    },
    series: [45, 15, 12, 10, 8, 10],
    labels: ['Development', 'UI/UX Design', 'Marketing', 'Human Resources', 'Finance Desk', 'Peripheral Operations'],
    colors: ['#4f46e5', '#06b6d4', '#f59e0b', '#10b981', '#6366f1', '#94a3b8'],
    legend: {
        position: 'bottom',
        labels: { colors: '#475569', fontWeight: 500 }
    },
    dataLabels: { enabled: false },
    plotOptions: {
        pie: {
            donut: {
                size: '75%',
                labels: {
                    show: true,
                    total: {
                        show: true,
                        label: 'Total Roster',
                        fontSize: '12px',
                        fontWeight: 600,
                        color: '#94a3b8'
                    }
                }
            }
        }
    }
};

new ApexCharts(document.querySelector("#departmentChartLayout"), departmentChartOptions).render();
</script>