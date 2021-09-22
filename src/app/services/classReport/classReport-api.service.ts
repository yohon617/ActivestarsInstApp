import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http } from '@angular/http';

import { ConfigService } from './../../config/config.service';

import { Observable } from 'rxjs/Rx';
import 'rxjs/add/operator/toPromise';

import { ClassReport } from './../../models/classReport';

@Injectable()
export class ClassReportAPIService {
    
    constructor(private http: Http, private config: ConfigService) { }
    
    getClassReport(classReportID): Promise<ClassReport> {
        return this.http.get(this.config.get("apiURL") + "/api/classreports.mvc/GetClassReport?classReportID=" + classReportID, this.config.requestOptions)
            .toPromise()
            .then(response => response.json() as ClassReport)
    }

  uploadClassReportFile(files: File[], classReportID: number, type: number): Promise<any> {
    let formData: FormData = new FormData();
    console.log(files[0].name);
    formData.append('uploadFile', files[0], files[0].name);
    //formData.append('uploadBase64File', base64File);

    //console.log(base64File);
        
    return this.http.post(this.config.get("apiURL") + "/api/classreports.mvc/UploadClassReportFile?classReportID=" + classReportID + "&fileType=" + type, formData, this.config.requestOptionsNonJSON)
        .toPromise()
        .then(response => response.json())
      .catch(error => Promise.reject(error));

  }

    deleteClassReportFile(classReportID: number, type: number, fileName: string): Promise<any> {
        return this.http.post(this.config.get("apiURL") + "/api/classreports.mvc/DeleteClassReportFile?classReportID=" + classReportID + "&fileType=" + type + "&fileName=" + fileName,
            JSON.stringify(""), this.config.requestOptionsNonJSON)
            .toPromise()
            .then(response => response.json())
            .catch(error => { console.log(error) });
        //return new Promise<any>((resolve, reject) => {
        //});
    }

    updateClassReportRaffle(classReportID: number, rafflePack: number, raffleAmount: number): Promise<any> {
        return this.http.post(this.config.get("apiURL") + "/api/classreports.mvc/UpdateClassReportRaffle?classReportID=" + classReportID + "&rafflePack=" + rafflePack
            + "&raffleAmount=" + raffleAmount
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json());
    }

    submitClassReport(classReportID: number): Promise<any> {
        return this.http.post(this.config.get("apiURL") + "/api/classreports.mvc/UpdateClassReportInstSubmit?classReportID=" + classReportID
            , JSON.stringify(""), this.config.requestOptions)
            .toPromise()
            .then(response => response.json());
    }
}
