import { Injectable, Inject } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { RequestOptions, Headers, Http } from '@angular/http';

@Injectable()

export class ConfigService {

    private _config: Object = null;

    public requestOptions;
    public requestOptionsNonJSON;
    public sessionUserID;

    constructor(private http: Http, @Inject('Session_UserID') private session_UserID ) {}

    public load() {
        return new Promise((resolve, reject) => {
            console.log('loading config');
            this.http.get('assets/config.json') //app/config
                .map(res => res.json())
                .subscribe((config_data => {
                    this._config = config_data;
                    this.sessionUserID = this.session_UserID;
                    this.requestOptions = new RequestOptions({
                        "headers": new Headers({ 'Content-Type': 'application/json', 'Region': this.get('region'), 'InstructorID': this.sessionUserID, 'SecurityToken': this.get('securityToken') })
                    });
                    this.requestOptionsNonJSON = new RequestOptions({
                        "headers": new Headers({ 'Region': this.get('region'), 'InstructorID': this.sessionUserID, 'SecurityToken': this.get('securityToken') })
                    });

                    resolve();
                }));
        });
    }

    public get(key: any) {
        return this._config[key];
    }
};