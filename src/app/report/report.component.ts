import { Component, OnInit, ViewChild } from '@angular/core';
import { TabsetComponent } from 'ngx-bootstrap';

import { ClassReportService } from './../services/classReport/classReport.service';
import { ClassReport } from './../models/classReport'
import { ClassService } from './../services/class/class.service';

@Component({
  selector: 'app-root',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent implements OnInit {

    classReport: ClassReport;
    subscription: any;
    
    constructor(private classReportService: ClassReportService,
        private classService: ClassService)
    { }

    ngOnInit(): void {
        this.subscription = this.classService.weekChange$.subscribe(() => {
            this.getClassReport();
        })

        if (this.classService.SelectedClassWeeks != null) {
            this.getClassReport();
        }
    }

    getClassReport() {
        this.classReportService.getClassReport(this.classService.SelectedClassWeek.ClassReportID)
            .then(response => {
                this.classReport = response;
            });
    }

    fileChange(event, type) {
        this.classReportService.uploadClassReportFile(event.target.files, this.classService.SelectedClassWeek.ClassReportID, type)
            .then(() => {
                this.getClassReport();
            });
    }

    getFileName(fullFilePath: string): string {
        let fileNames: string[];
        fileNames = fullFilePath.split("/");
        return fileNames[(fileNames.length - 1)];
    }

    deleteFile(type: number, fileName: string) {
        this.classReportService.deleteClassReportFile(this.classService.SelectedClassWeek.ClassReportID, type, fileName)
            .then(() => {
                this.getClassReport();
            });
    }
}
