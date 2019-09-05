import { Injectable, Inject } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { RequestOptions, Headers, Http } from '@angular/http';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

@Injectable()

export class ConfigService {

    private _config: Object = null;

    public requestOptions;
    public requestOptionsNew;
    public requestOptionsNonJSON;
    public sessionUserID;

    constructor(private http: HttpClient, @Inject('Session_UserID') private session_UserID ) {}

    public load() {
        return this.http.get('app/config/config.json') //app/config
                .map(res => res)
                .toPromise()
                .then(config_data => {
                //.subscribe(config_data => {
                  console.log(config_data);
                    this._config = config_data;
                    this.sessionUserID = this.session_UserID;
                    this.requestOptions = new RequestOptions({
                        "headers": new Headers({ 'Content-Type': 'application/json', 'Region': this.get('region'), 'InstructorID': this.sessionUserID, 'SecurityToken': this.get('securityToken') })
                    });
                    this.requestOptionsNew = {
                      headers: new HttpHeaders({ 'Content-Type': 'application/x-www-form-urlencoded', 'Region': this.get('region'), 'InstructorID': "" + this.sessionUserID + "", 'SecurityToken': this.get('securityToken') }),
                      responseType: 'json'
                    };
                  console.log(this.requestOptionsNew);
                    this.requestOptionsNonJSON = new RequestOptions({
                        "headers": new Headers({ 'Region': this.get('region'), 'InstructorID': this.sessionUserID, 'SecurityToken': this.get('securityToken') })
                    });
                    //this.requestOptionsNonJSON = {
                    //    headers: new HttpHeaders({ 'Region': this.get('region'), 'InstructorID': this.sessionUserID, 'SecurityToken': this.get('securityToken') })
                    //};
                });
    }

    public get(key: any) {
        return this._config[key];
    }
};
