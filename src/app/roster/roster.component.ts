import { Component, OnInit, OnDestroy, TemplateRef } from '@angular/core';
import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal/modal-options.class';

import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';

import { ClassService } from './../services/class/class.service';
import { StudentService } from './../services/student/student.service';
import { Student } from './../models/student';
import { StudentRoster } from './../models/studentRoster';

@Component({
  selector: 'roster',
  templateUrl: './roster.component.html',
  styleUrls: ['./roster.component.css']
})
export class RosterComponent implements OnInit, OnDestroy {

    public modalRef: BsModalRef;

    //studentList: StudentRoster[] = [];
    studentList: StudentRoster[];
    subscription: any;

    selectedWeekStudentList: StudentRoster[];
    studentListByClassNumber: StudentRoster[][] = [];

    selectedClassNumber: number = 1;
    selectedStudentRoster: StudentRoster;

    dropRequestStudent: StudentRoster;
    txtDropReason: string;
    
    constructor(
        private studentService: StudentService,
        private classService: ClassService,
        private modalService: BsModalService
    ) { }

    ngOnInit(): void {
        this.subscription = this.classService.weekChange$.subscribe(() => {
            this.getStudentRosters();
        })

        if (this.classService.SelectedClassWeeks != null) {
            this.getStudentRosters();
        }
    }

    ngOnDestroy() {
        // TODO: is there a better way of doing this?
        this.subscription.unsubscribe();
    }

    getStudentRosters() {
        this.studentService.getStudentRosters(this.classService.SelectedClassWeek.ClassReportID).then(
            response => {
                this.studentList = response;
                this.studentListByClassNumber = [];
                //this.selectedClassNumber = 1;

                for (let student of this.studentList) {
                    //console.log(this.studentListByClassNumber);
                    if (this.studentListByClassNumber[student.ClassNumber] === undefined) {
                        this.studentListByClassNumber[student.ClassNumber] = [];
                    }
                    this.studentListByClassNumber[student.ClassNumber].push(student);
                }
                this.selectedWeekStudentList = this.studentListByClassNumber[this.selectedClassNumber];
            });
    }

    prevClass() {
        if (this.selectedClassNumber > 1) {
            this.selectedClassNumber--;
            this.selectedWeekStudentList = this.studentListByClassNumber[this.selectedClassNumber];
        }
    }

    nextClass() {
        if (this.selectedClassNumber < this.studentListByClassNumber.length - 1) {
            this.selectedClassNumber++;
            this.selectedWeekStudentList = this.studentListByClassNumber[this.selectedClassNumber];
        }

    }

    public openCheckIn(template: TemplateRef<any>, studentRoster: StudentRoster) {
        this.selectedStudentRoster = studentRoster;
        this.modalRef = this.modalService.show(template);
    }

    refreshRoster() {
        this.getStudentRosters();
        console.log("refresh roster");
    }

    setStudentAB(studentID) {
        //console.log(studentID);
        this.studentService.CheckInStudent(studentID, this.classService.SelectedClassWeek.ClassReportID, "AB", 0, 0, "", 0, 0, 0, 0, false, 0, "")
            .then(() => {
                this.refreshRoster();
            });
    }

    setStudentNP(studentID) {
        //console.log(studentID);
        this.studentService.CheckInStudent(studentID, this.classService.SelectedClassWeek.ClassReportID, "NP", 0, 0, "", 0, 0, 0, 0, false, 0, "")
            .then(() => {
                this.refreshRoster();
            });
    }

    dropStudent(template: TemplateRef<any>, dropRequestStudent: StudentRoster) {
        this.modalRef = this.modalService.show(template);
        this.dropRequestStudent = dropRequestStudent;
    }

    requestDrop()
    {
        this.studentService.AddDropStudentRequest(this.dropRequestStudent.StudentID, this.classService.SelectedClassWeek.ClassReportID, this.txtDropReason + " (Student ID: " + this.dropRequestStudent.StudentID + ")")
            .then(() => {
                this.refreshRoster();
                this.modalRef.hide();
            });
    }

  getClassTeamName() {
    switch (this.selectedClassNumber) {
      case 1:
        return this.classService.SelectedClass.TeamName1 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName1;
      case 2:
        return this.classService.SelectedClass.TeamName2 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName2;
      case 3:
        return this.classService.SelectedClass.TeamName3 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName3;
      case 4:
        return this.classService.SelectedClass.TeamName4 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName4;
      case 5:
        return this.classService.SelectedClass.TeamName5 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName5;
      case 6:
        return this.classService.SelectedClass.TeamName6 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName6;
      case 7:
        return this.classService.SelectedClass.TeamName7 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName7;
      case 8:
        return this.classService.SelectedClass.TeamName8 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName8;
      case 9:
        return this.classService.SelectedClass.TeamName9 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName9;
      case 10:
        return this.classService.SelectedClass.TeamName10 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName10;
      case 11:
        return this.classService.SelectedClass.TeamName11 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName11;
      case 12:
        return this.classService.SelectedClass.TeamName12 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName12;
      case 13:
        return this.classService.SelectedClass.TeamName13 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName13;
      case 14:
        return this.classService.SelectedClass.TeamName14 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName14;
      case 15:
        return this.classService.SelectedClass.TeamName15 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName15;
      case 16:
        return this.classService.SelectedClass.TeamName16 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName16;
      case 17:
        return this.classService.SelectedClass.TeamName17 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName17;
      case 18:
        return this.classService.SelectedClass.TeamName18 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName18;
      case 19:
        return this.classService.SelectedClass.TeamName19 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName19;
      case 20:
        return this.classService.SelectedClass.TeamName20 == "" ? "Class " + this.selectedClassNumber.toString() : this.classService.SelectedClass.TeamName20;
      default:
        return "Class " + this.selectedClassNumber.toString();
    }
  }

}
