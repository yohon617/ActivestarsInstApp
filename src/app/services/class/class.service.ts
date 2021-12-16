import { Injectable } from '@angular/core';
//import { Http } from '@angular/http';
import { HttpClient } from '@angular/common/http';


import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

import 'rxjs/add/operator/toPromise';

import { ClassAPIService } from './class-api.service';

import { Class }  from './../../models/class';
import { ClassWeek } from './../../models/classWeek';
import { ClassTeam } from './../../models/classTeam';
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
        this.setSelectedClassTeams();
        this.getNewClassWeeks();
        return classes;
      });
  }

  classSelectedChange(changedClass: Class) {
    this.selectedClass = changedClass;
    this.setSelectedClassTeams();
    this.getNewClassWeeks();
  }

  setSelectedClassTeams() {
    this.selectedClass.ClassTeams = [
      { ClassNumber: 1, TeamName: this.selectedClass.TeamName1 == "" ? "1" : "1 - " + this.selectedClass.TeamName1 },
      { ClassNumber: 2, TeamName: this.selectedClass.TeamName2 == "" ? "2" : "2 - " + this.selectedClass.TeamName2 },
      { ClassNumber: 3, TeamName: this.selectedClass.TeamName3 == "" ? "3" : "3 - " + this.selectedClass.TeamName3 },
      { ClassNumber: 4, TeamName: this.selectedClass.TeamName4 == "" ? "4" : "4 - " + this.selectedClass.TeamName4 },
      { ClassNumber: 5, TeamName: this.selectedClass.TeamName5 == "" ? "5" : "5 - " + this.selectedClass.TeamName5 },
      { ClassNumber: 6, TeamName: this.selectedClass.TeamName6 == "" ? "6" : "6 - " + this.selectedClass.TeamName6 },
      { ClassNumber: 7, TeamName: this.selectedClass.TeamName7 == "" ? "7" : "7 - " + this.selectedClass.TeamName7 },
      { ClassNumber: 8, TeamName: this.selectedClass.TeamName8 == "" ? "8" : "8 - " + this.selectedClass.TeamName8 },
      { ClassNumber: 9, TeamName: this.selectedClass.TeamName9 == "" ? "9" : "9 - " + this.selectedClass.TeamName9 },
      { ClassNumber: 10, TeamName: this.selectedClass.TeamName10 == "" ? "10" : "10 - " + this.selectedClass.TeamName10 },
      { ClassNumber: 11, TeamName: this.selectedClass.TeamName11 == "" ? "11" : "11 - " + this.selectedClass.TeamName11 },
      { ClassNumber: 12, TeamName: this.selectedClass.TeamName12 == "" ? "12" : "12 - " + this.selectedClass.TeamName12 },
      { ClassNumber: 13, TeamName: this.selectedClass.TeamName13 == "" ? "13" : "13 - " + this.selectedClass.TeamName13 },
      { ClassNumber: 14, TeamName: this.selectedClass.TeamName14 == "" ? "14" : "14 - " + this.selectedClass.TeamName14 },
      { ClassNumber: 15, TeamName: this.selectedClass.TeamName15 == "" ? "15" : "15 - " + this.selectedClass.TeamName15 },
      { ClassNumber: 16, TeamName: this.selectedClass.TeamName16 == "" ? "16" : "16 - " + this.selectedClass.TeamName16 },
      { ClassNumber: 17, TeamName: this.selectedClass.TeamName17 == "" ? "17" : "17 - " + this.selectedClass.TeamName17 },
      { ClassNumber: 18, TeamName: this.selectedClass.TeamName18 == "" ? "18" : "18 - " + this.selectedClass.TeamName18 },
      { ClassNumber: 19, TeamName: this.selectedClass.TeamName19 == "" ? "19" : "19 - " + this.selectedClass.TeamName19 },
      { ClassNumber: 20, TeamName: this.selectedClass.TeamName20 == "" ? "20" : "20 - " + this.selectedClass.TeamName20 }
    ];
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
    this.setSelectedClassTeams();
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
