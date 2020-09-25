import { Injectable } from '@angular/core';
//import { Http } from '@angular/http';
import { HttpClient } from '@angular/common/http';


import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

import 'rxjs/add/operator/toPromise';

import { ClassAPIService } from './class-api.service';

import { Class }           from './../../models/class';
import { ClassWeek }           from './../../models/classWeek';
import { RPTClassSalesAndRetention } from './../../models/rptClassSalesAndRetention';

@Injectable()
export class ClassService {

  private selectedClass: Class;
  private selectedClassWeeks: ClassWeek[];
  private selectedWeek: ClassWeek;
  private weekChange = new Subject<string>();
  public weekChange$ = this.weekChange.asObservable();

  private selectedWeekArrayNumber: number = 0;

  constructor(private http: HttpClient, private classAPIService: ClassAPIService) { }

  getClasses(): Promise<Class[]> {
    return this.classAPIService.getClasses()
      .then(classes => {
        this.selectedClass = classes[0];
        this.getNewClassWeeks();
        return classes;
      });
  }

  classSelectedChange(changedClass: Class) {
    this.selectedClass = changedClass;
    this.getNewClassWeeks();
  }

  getNewClassWeeks() {
    this.classAPIService.getClassWeeks(this.selectedClass.ID)
      .then(weeks => {
        this.selectedClassWeeks = weeks;

        if (weeks.length > 0)
          this.selectedWeekArrayNumber = weeks.length - 1;
        else
          this.selectedWeekArrayNumber = 0;

        var tmpCount = 0;
        for (let week of this.selectedClassWeeks) {
          //console.log(week.WeekNumber);
          //console.log(new Date().getTime());
          //console.log(new Date(week.ClassDate).getTime());
          //console.log(new Date(week.ClassDate).getTime() + (60 * 60 * 24 * 1000));
          //console.log(new Date(new Date(week.ClassDate).getTime() + (60 * 60 * 24 * 1000)));
          //console.log(new Date());
          //console.log(new Date(week.ClassDate));

          //if (week.WeekNumber == this.selectedClass.NumOfWeeks) {
          //  this.selectedWeek = week;
          //  this.weekChange.next();
          //}
          //else
          if (new Date().getTime() < new Date(new Date(week.ClassDate).getTime() + (60 * 60 * 24 * 1000)).getTime()) {
            //this.selectedWeek = week;
            //this.weekChange.next();
            this.selectedWeekArrayNumber = tmpCount;
            break;
          }
          tmpCount++;

        }
        this.selectedWeek = weeks[this.selectedWeekArrayNumber];
        this.weekChange.next();
      });
  }

  postTest(): Promise<string> {
    return this.classAPIService.postTest()
      .then(result => result);
  }

  uploadFile(files: File[]) {
    return this.classAPIService.uploadFile(files);
  }

  moveNextWeek() {
    if (this.selectedWeekArrayNumber + 1 < this.selectedClassWeeks.length) {
      this.selectedWeekArrayNumber++;
      this.selectedWeek = this.selectedClassWeeks[this.selectedWeekArrayNumber];
      this.weekChange.next();
    }
  }

  movePrevWeek() {
    if (this.selectedWeekArrayNumber > 0) {
      this.selectedWeekArrayNumber--;
      this.selectedWeek = this.selectedClassWeeks[this.selectedWeekArrayNumber];
      this.weekChange.next();
    }
  }

  get SelectedWeekArrayNumber(): number {
    return this.selectedWeekArrayNumber;
  }

  set SelectedWeekArrayNumber(value: number) {
    this.selectedWeekArrayNumber = value;
  }

  get SelectedClass(): Class {
    return this.selectedClass;
  }

  set SelectedClass(value: Class) {
    this.selectedClass = value;
  }

  get SelectedClassWeeks(): ClassWeek[] {
    return this.selectedClassWeeks;
  }

  get SelectedClassWeek(): ClassWeek {
    return this.selectedWeek;
  }

  set SelectedClassWeek(value: ClassWeek) {
    this.selectedWeek = value;
    this.weekChange.next();
  }

  get WeekChange(): Subject<string> {
    return this.weekChange;
  }

  sendClassEmail(classID: number, subject: string, body: string): Promise<boolean> {
    return this.classAPIService.sendClassEmail(classID, subject, body);
  }

  sendStudentEmail(from: string, to: string, subject: string, body: string): Promise<boolean> {
    return this.classAPIService.sendStudentEmail(from, to, subject, body);
  }

  getInstructorEmail(): Promise<string> {
    return this.classAPIService.getInstructorEmail();
  }

  getClassSalesAndRententionReport(classID: number): Promise<RPTClassSalesAndRetention[]> {
    return this.classAPIService.getClassSalesAndRententionReport(classID)
  }
}
