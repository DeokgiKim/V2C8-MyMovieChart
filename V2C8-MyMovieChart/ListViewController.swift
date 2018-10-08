//
//  ListViewController.swift
//  V2C8-MyMovieChart
//
//  Created by KDG on 29/09/2018.
//  Copyright © 2018 deokgikim. All rights reserved.
//

//import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        // MARK: 리스트 추가하는 방법 - 1

//        // 테이블 뷰를 구성할 리스트 데이터 인스턴스 생성
//        var list = [MovieVO]()  // MovieVO를 내용으로 하는 Array 선언

//        // 첫번째 행
//        var mvo = MovieVO()     // MovieVO 인스턴스 생성
//        mvo.title = "다크나이트"
//        mvo.description = "영웅물에 철학에 음악까지 더해져 예술이 되다"
//        mvo.opendate = "2008-09-04"
//        mvo.rating = 8.95
//        self.list.append(mvo)           // 배열에 추가
//
//
//        // 두번째 행 : mvo를 재활용하여 list에 넣음
//        mvo = MovieVO()     // MovieVO 인스턴스 생성 : 식판을 리셋해줌(새로운 정보가 업데이트 안되는 경우, 내용이 꼬임) p.512 ★★
//        mvo.title = "호우시절"
//        mvo.description = "때를 알고 내리는 좋은 비"
//        mvo.opendate = "2009-10-08"
//        mvo.rating = 7.31
//        self.list.append(mvo)           // 배열에 추가
//
//        // 세번째 행
//        mvo = MovieVO()     // MovieVO 인스턴스 생성 : 식판을 리셋해줌
//        mvo.title = "말할 수 없는 비밀"
//        mvo.description = "여기서 너까지 다섯 걸음"
//        mvo.opendate = "2015-05-07"
//        mvo.rating = 9.19
//        self.list.append(mvo)           // 배열에 추가
        
        
        // 배열에 모두 잘 들어갔는지 확인 : for~in 루프순회를 하면 순회값(여기에선 i)는 자동으로 한 값씩 증가함 ★
        for i in 0 ..< list.count {
            print(self.list[i].title!)
        }
    }
    
    // MARK: 리스트 추가하는 방법 - 2
    /// 순서1: 튜플 아이템을 가진 배열인 dataset를 만듦
    var dataset = [
        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다", "2008-09-04", 8.95, "darknight.jpg"),
        ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
        ("말할 수 없는 비밀", nil, "2015-05-07", 9.19, "secret.jpg")     // description에 nil을 할당
    ]
    
    /// 순서2: MovieVO로 구성된 Array인 list 정의
    /// 순서3: {}()로 클로저 생성 -> {}안에 테이블 뷰를 구성할 datalist를 만들고, return값으로 datalist를 반환하여 list값으로 사용.
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumnail = thumbnail
            
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    /// 각 셀에서 구현할 내용을 정의
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let dataForEachRow = self.list[indexPath.row]  // 표시될 indexPath의 줄(row, Int값)를 리스트의 index로 활용함.
        
        // 테이블 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell   // nil 가능성 없음 ★
        cell.title?.text = dataForEachRow.title     // 옵셔널 체인 대입 구문(좌변or우변 nil이 발생해도 오류나지 않음)★
        cell.desc?.text = dataForEachRow.description
        cell.opendate?.text = dataForEachRow.opendate
        cell.rating?.text = "\(dataForEachRow.rating!)"
        cell.thumbnail?.image = UIImage(named: dataForEachRow.thumnail!)
        
        return cell
    }
    
    /// 셀이 선택되었을 때 구현되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")

        // MARK: 내가 만들어 본 알람창
        let alert = UIAlertController(
            title: "\(self.list[indexPath.row].title!)",
            message: "선택된 행은 \(indexPath.row) 번째 행입니다.",
            preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
