import { Component, OnInit, ViewChild, TemplateRef } from '@angular/core';
import { TabsetComponent } from 'ngx-bootstrap';
import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal/modal-options.class';

import { ClassReportService } from './../services/classReport/classReport.service';
import { ClassReport } from './../models/classReport'
import { ClassService } from './../services/class/class.service';

@Component({
  selector: 'app-root',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent implements OnInit {

    public modalRef: BsModalRef;
    classReport: ClassReport;
    subscription: any;
    result: string;
    resultClass: string;
    
    constructor(private classReportService: ClassReportService,
      private classService: ClassService,
      private modalService: BsModalService)
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

  fileChange(template: TemplateRef<any>, event, type) {
        this.resultClass = "resultProcessing";
        this.result = "Uploading File...";
        this.modalRef = this.modalService.show(template);
        this.classReportService.uploadClassReportFile(event.target.files, this.classService.SelectedClassWeek.ClassReportID, type)
          .then(() => {
            this.getClassReport();
            this.resultClass = "resultSuccess";
            this.result = "File Upload Successful.";
          })
          .catch((err) => {
            console.log(err);
            this.resultClass = "resultFail";
            this.result = "File Upload Failed, please try again.";
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

    updateRaffle(e) {
        e.target.textContent = "Updating..";
        e.target.disabled = true;
        //e.target.classList = "btn btn-default";

        this.classReportService.updateClassReportRaffle(this.classService.SelectedClassWeek.ClassReportID, this.classReport.RafflePack, this.classReport.RaffleAmount)
            .then(() => {
                this.getClassReport();
                e.target.textContent = "Updated";
                e.target.disabled = false;
                //e.target.classList = "btn btn-primary";
                setTimeout(() => {    //<<<---    using ()=> syntax
                    e.target.textContent = "Update Raffle";
                    //e.target.classList = "btn btn-success";
                }, 2000);
            });
    }

    submitClassReport(e) {
          e.target.textContent = "Submitting...";
          e.target.disabled = true;
          //e.target.classList = "btn btn-default";

          this.classReportService.submitClassReport(this.classService.SelectedClassWeek.ClassReportID)
              .then(() => {
                  this.getClassReport();
                  e.target.textContent = "Submitted";
                  e.target.disabled = false;
                  //e.target.classList = "btn btn-primary";
                  setTimeout(() => {    //<<<---    using ()=> syntax
                      e.target.textContent = "Submit Class Report";
                      //e.target.classList = "btn btn-success";
                  }, 2000);
              });
    }
}
