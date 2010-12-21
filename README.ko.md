# 쥬라기원시전2 SPZ편집기

쥬라기원시전2의 유닛 이미지 파일(SPZ)을 BMP로 꺼내고, 고친 BMP를 다시 SPZ로 되돌리는 편집기다.

분석 결과는 [docs/spz-format.ko.md](docs/spz-format.ko.md) 에 정리해뒀다.

<p>
  <img src="docs/screenshots/screenshot-1.png" width="315" alt="편집 방식 선택 화면">
</p>


## 사용 방법

Releases에서 받아 압축을 풀고 실행하면 세 가지 중 하나를 고르게 한다.

`SPZ->BMP` 는 색을 담은 `.pnt`, SPZ가 든 폴더, 저장할 폴더를 물어보고 폴더 안의 SPZ를 전부 BMP로 바꾼다. 저장 폴더에 `세부사항.txt` 도 같이 나오는데 그 PNT의 투명색, 그림자색, 플레이어 색상 열 개가 적혀 있다.

`BMP->SPZ` 는 BMP가 든 폴더, 저장할 PNT 이름, 저장할 폴더를 물어보고 전부 되돌린다. 색상 지정은 같이 들어 있는 `옵션.ini` 에서 한다.

`SPZ중점변경` 은 SPZ 하나를 골라 중점과 충돌점 좌표만 고친다.

되돌릴 때는 BMP 전체에서 쓴 색이 256색을 넘으면 안 된다.


## 구현 원리

**투명 구간을 반복 개수로 묶어 저장하는 포맷이다.** 픽셀 하나가 팔레트 인덱스 1바이트인데, 인덱스 0은 투명이고 그 뒤에 반복 개수 1바이트가 붙는다. 유닛 그림은 사각형 안에서 실제 그림이 차지하는 부분이 좁아 투명이 많다. 그래서 이 한 가지 규칙만으로 크기가 크게 준다.

```gml
xred[i, k] = file_bin_read_byte(abc)

if xred[i, k]=0                       // 투명이면 다음 바이트가 반복 개수
{
  vars2 = file_bin_read_byte(abc)
  for(u=0; u!=vars2; u+=1){ xred[i, k+u]=0 }
  k += vars2-1
}
```

**팔레트 번호를 뒤집어 쓴다.** PNT는 0번이 투명, 1번이 그림자로 고정이고 나머지는 뒤에서부터 채워진다. 그래서 SPZ에 인덱스를 적을 때도 0과 1은 그대로, 나머지는 `257 - 번호` 로 바꿔서 적는다. 이렇게 해야 투명이 항상 0번 자리를 지켜서 반복 규칙이 성립한다.

```gml
if argument1=0 or argument1=1
{
  file_bin_write_byte(argument0, argument1)
}
else
{
  file_bin_write_byte(argument0, 255-argument1+2)
}
```

**중점과 충돌점은 음수로 들어 있다.** 4바이트 값인데 2의 보수라 그냥 읽으면 42억대 숫자가 나온다. `4294967296` 에서 빼서 실제 좌표를 얻고, 쓸 때는 그 반대로 돌린다.

```gml
posxx = abs(real(sk_dec_conversion(...)) - 4294967295 - 1)
```

**BMP 쓰기는 게임메이커 밖으로 넘겼다.** GML의 `file_bin_write_byte` 로 픽셀을 한 바이트씩 찍으면 이미지 한 장에 수십만 번을 돌아야 해서 너무 느렸다. 그래서 GML은 생 RGB 스트림을 `spz.tmp` 에 뱉고 BMP의 54바이트 헤더만 직접 쓴 다음, 행 뒤집기와 4바이트 정렬 패딩은 따로 만든 `RGBtoBMP` 에 넘겼다. 콘솔 창이 뜨지 않게 `silent_dos.dll` 의 `RunSilent` 를 `external_define` 으로 붙여서 호출한다.

```gml
// stdos_dll_init.gml
global.stdos_cmd = external_define(argument0, 'RunSilent', dll_stdcall, ty_real, 2, ty_string, ty_string)

// 호출부
stdos_command("RGBtoBMP.dll",
  chr(34)+dir+"\"+"spz.tmp"+chr(34)+" "+chr(34)+string(bmp)+chr(34)+" "
  +chr(34)+string(posx)+chr(34)+" "+chr(34)+string(su)+chr(34), 1)
```

`RGBtoBMP.dll` 은 이름만 dll이고 실제로는 콘솔 실행 파일이다. 원본 파일 이름을 그대로 뒀다.

**색상 지정은 ini로 뺐다.** 투명색, 그림자색, 플레이어 색상 열 개를 `옵션.ini` 에서 읽는다. SPZ에서 꺼낼 때 그림자를 투명으로 눌러버릴지도 여기서 정한다. 유닛마다 쓰는 색이 달라서 프로그램을 고치지 않고 바꿀 수 있게 했다.


## 파일

| 경로 | 내용 |
|---|---|
| `source/jw2-spz-editor.gmk` | 원본 프로젝트 파일 |
| `source/split/` | GmkSplitter로 분해한 텍스트 트리 |
| `source/RGBtoBMP.dll`, `source/silent_dos.dll` | 실행에 필요한 외부 라이브러리와 실행 파일 |
| `docs/spz-format.ko.md` | SPZ 포맷 분석 자료 |
| `docs/screenshots/` | 스크린샷 |
| Releases | 실행 파일, DLL, 옵션 파일, 사용 설명 |


## 크레딧

`silent_dos.dll` 은 게임메이커 커뮤니티의 TGMG가 만들었다. `RGBtoBMP.dll` 은 직접 만들었다.


## 라이선스

zlib 라이선스다. 자세한 내용은 [LICENSE](LICENSE) 에 있다. 함께 들어 있는 것 중 다른 사람이 만든 라이브러리는 각자의 라이선스를 따른다.
