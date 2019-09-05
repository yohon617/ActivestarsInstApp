import { Component } from '@angular/core';

import { ClassService } from './../services/class/class.service';
import { ConfigService } from './../config/config.service';
import { RPTClassSalesAndRetention } from './../models/rptClassSalesAndRetention';

declare var google: any;
let salesReports: any[] = new Array();
let retentionReports: any[] = new Array();

@Component({
  selector: 'app-root',
  templateUrl: './classes.component.html',
  styleUrls: ['./classes.component.css']
})
export class ClassesComponent {
    configTest: string;
    rptClassSalesAndRetentions: RPTClassSalesAndRetention[];
    subscription: any;

    constructor(private classService: ClassService, private config: ConfigService) { }
    
  ngOnInit(): void {
    //this.configTest = this.config.get('environment') + ", " + this.config.get('region') + ", " + this.config.sessionUserID;

    this.subscription = this.classService.weekChange$.subscribe(() => {
      this.loadReport();
    })
  }

  loadReport() {

    //console.log(this.classService.SelectedClass);
    this.classService.getClassSalesAndRententionReport(this.classService.SelectedClass.ID)
      .then(reports => {
        this.rptClassSalesAndRetentions = reports;
        console.log(this.rptClassSalesAndRetentions);

        salesReports = [];
        retentionReports = [];
        salesReports.push(['Opening Move', 'Sales', { role: 'annotation' }]);
        retentionReports.push(['Opening Move', 'Retention', { role: 'annotation' }]);

        if (this.rptClassSalesAndRetentions.length > 0) {
          this.rptClassSalesAndRetentions.forEach(function (report) {
            salesReports.push(["WK " + report.Week, Math.round(report.AverageSales * 100) / 100, "$" + String(Math.round(report.AverageSales * 100) / 100)]);
            retentionReports.push(["WK " + report.Week, Math.round(report.AverageRetention * 100) / 100, String(Math.round(report.AverageRetention * 100) / 100)]);
          });
        }
        else {
          salesReports.push(['-', 0, '-']);
          retentionReports.push(["-", 0, '-']);
        }

        google.charts.load('current', { 'packages': ['corechart', 'bar'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

          //[
          //  ['Opening Move', 'Sales', { role: 'annotation' }],
          //  ["King's pawn (e4)", 2.10, 'fdaf'],
          //  ["Queen's pawn (d4)", 1.80, 'fdaf'],
          //  ["Knight to King 3 (Nf3)", 2.14, 'fdaf'],
          //  ["Queen's bishop pawn (c4)", 2.9, 'fdaf'],
          //  ['Other', 3, 'fdaf']
          //]
          //[
          //  ['Opening Move', 'Retention', { role: 'annotation' }],
          //  ["King's pawn (e4)", 2.10, '2.1'],
          //  ["Queen's pawn (d4)", 1.80, '2.1'],
          //  ["Knight to King 3 (Nf3)", 2.14, '2.1'],
          //  ["Queen's bishop pawn (c4)", 2.9, '2.1'],
          //  ['Other', 3, '2.1']
          //]

          //salesReports.push(["King's pawn (e4)", 2.10, 'fdaf']);
          //salesReports.push(["Queen's pawn (d4)", 1.80, 'fdaf']);
          //salesReports.push(["Knight to King 3 (Nf3)", 2.14, 'fdaf']);
          //salesReports.push(["Queen's bishop pawn (c4)", 2.9, 'fdaf']);
          //salesReports.push(['Other', 3, 'fdaf']);

          //retentionReports.push(["King's pawn (e4)", 2.10, '2.1']);
          //retentionReports.push(["Queen's pawn (d4)", 1.80, '2.1']);
          //retentionReports.push(["Knight to King 3 (Nf3)", 2.14, '2.1']);
          //retentionReports.push(["Queen's bishop pawn (c4)", 2.9, '2.1']);
          //retentionReports.push(['Other', 3, '2.1']);

          var data = new google.visualization.arrayToDataTable(salesReports);

          var options = {
            title: 'Sales',
            width: '100%',
            height: 400,
            colors: ['#98D145'],
            legend: { position: 'none' },
            chart: {
              title: 'Sales',
              subtitle: ''
            },
            bars: 'vertical', // Required for Material Bar Charts.
            axes: {
              x: {
                0: { side: 'bottom', label: 'Week' } // Top x-axis.
              }
            },
            bar: { groupWidth: "90%" }
          };

          //var chart = new google.charts.Bar(document.getElementById('salesBarChart'));
          var chart = new google.visualization.ColumnChart(document.getElementById("salesBarChart"));
          chart.draw(data, options);


          var data2 = new google.visualization.arrayToDataTable(retentionReports);


          var options2 = {
            title: 'Retention',
            width: '100%',
            height: 400,
            colors: ['#F9BF00'],
            legend: { position: 'none' },
            chart: {
              title: 'Retention',
              subtitle: ''
            },
            bars: 'vertical', // Required for Material Bar Charts.
            axes: {
              x: {
                0: { side: 'bottom', label: 'Week' } // Top x-axis.
              }
            },
            bar: { groupWidth: "90%" }
          };

          //var chart = new google.charts.Bar(document.getElementById('retentionBarChart'));
          var chart = new google.visualization.ColumnChart(document.getElementById("retentionBarChart"));
          chart.draw(data2, options2);
        }


      });
  }
}
