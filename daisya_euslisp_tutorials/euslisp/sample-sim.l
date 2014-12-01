#|**************************************************
  robot������(simulator)��Ĥʤ��ǡ�ư����Ƥߤ���ñ����
  bumper�򲡤�������֤�ư��

  2010/12/1 written by nakanish

**************************************************|#
(load "robot-server-simulator.l")

(warn "(demo)~%")
(defun demo
  ()
  (let (result) ;;�ɽ��ѿ������
    ;;robot-server(simulator)�ȤĤʤ��äƤʤ��ä���Ĥʤ�
    (when (not *rs-sim*) (connect-robotsim-server))
    ;;
    ;;��֤�����⡼�ɤ����������ѹ�����
    (send *rs-sim* :daisya-controlmode 2)

    ;;key�򲡤����ޤ�³����
    (do-until-key
     ;;bumper�ξ��֤��������(6�Ĥ����Ǥ���ʤ�٥��ȥ뤬���äƤ���Ϥ�)
     (setq result (send *rs-sim* :bumper-vector))
     ;;bumper�ξ��֤�ɽ������(6�Ĥ����Ǥ���ʤ�٥��ȥ뤬ɽ�������Ϥ�)
     (warn "bumper-vector:~a~%" result)
     ;;bumper�ξ��֤˱�������֤ε�ư���ѹ�
     (cond
      ;;bumper0,���뤤��bumper5��������Ƥ������
      ((or (= (elt result 0) 1) (= (elt result 5) 1))
       ;;1�ä�����300[mm]�Хå�&��ž����
       (send *rs-sim* :daisya-position-vector #f(-300 0 50) 1000)
       ;;1�õ٤�
       (unix:sleep 1)
       )
      ;;bumper2,���뤤��bumper3��������Ƥ������
      ((or (= (elt result 2) 1) (= (elt result 3) 1))
       (send *rs-sim* :daisya-position-vector #f(300 0 0) 1000)
       (unix:sleep 1)
       )
      ;;bumper4��������Ƥ������
      ((= (elt result 4) 1)
       (send *rs-sim* :daisya-position-vector #f(0 200 0) 1000)
       (unix:sleep 1)
       )
      ;;bumper1��������Ƥ������
      ((= (elt result 1) 1)
       (send *rs-sim* :daisya-position-vector #f(0 -200 0) 1000)
       (unix:sleep 1)
       )
      ;;����ʳ��ξ��
      (t
       ;;�Ȥꤢ����ľ��, usleep�ϥޥ��������꡼�פΰ�̣
       (send *rs-sim* :daisya-position-vector #f(300 0 0) 1000)
       (unix:usleep (* 1000 1000))
       ))
     )
    ;;��������®��������ᤷ�Ƥ���(�Ĥ��Ǥ�speed��0�ˤ��Ƥ���)
    (send *rs-sim* :daisya-controlmode 1)
    (send *rs-sim* :daisya-velocity-vector #f(0 0 0))
    ))