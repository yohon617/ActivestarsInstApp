import { Injectable } from '@angular/core';
import { Http } from '@angular/http';

import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

import 'rxjs/add/operator/toPromise';

import { ClassReportAPIService } from './classReport-api.service';

import { ClassReport } from './../../models/classReport';

@Injectable()
export class ClassReportService {

    constructor(private http: Http, private classReportAPIService: ClassReportAPIService) { }

    getClassReport(classReportID): Promise<ClassReport> {
        return this.classReportAPIService.getClassReport(classReportID);
    }

    uploadClassReportFile(files: File[], classReportID: number, type: number): Promise<any> {
        return this.classReportAPIService.uploadClassReportFile(files, classReportID, type);
    }

    deleteClassReportFile(classReportID: number, type: number, fileName: string): Promise<any> {
        return this.classReportAPIService.deleteClassReportFile(classReportID, type, fileName);
    }

    updateClassReportRaffle(classReportID: number, rafflePack: number, raffleAmount: number): Promise<any> {
        return this.classReportAPIService.updateClassReportRaffle(classReportID, rafflePack, raffleAmount);
    }

    submitClassReport(classReportID: number): Promise<any> {
        return this.classReportAPIService.submitClassReport(classReportID);
    }
}
