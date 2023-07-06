<?php

namespace App\Http\Controllers;

use App\Models\DetalleOrden;
use App\Models\Equipo;
use App\Models\Herramienta;
use App\Models\HistorialFalla;
use App\Models\KardexRepuesto;
use App\Models\OrdenTrabajo;
use App\Models\PlanMantenimiento;
use App\Models\Producto;
use App\Models\Repuesto;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;

class ReporteController extends Controller
{
    public function usuarios(Request $request)
    {
        $filtro =  $request->filtro;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($filtro == 'Tipo de usuario') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }

    public function kardex_herramientas(Request $request)
    {
        $herramientas = Herramienta::all();

        $pdf = PDF::loadView('reportes.kardex_herramientas', compact('herramientas'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 130, 123, "{PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('kardex_herramientas.pdf');
    }
    public function informacion_herramientas(Request $request)
    {
        $filtro = $request->filtro;
        $herramienta_id = $request->herramienta_id;

        $herramientas = Herramienta::all();
        if ($filtro != "Todos") {
            $request->validate([
                "herramienta_id" => "required"
            ], [
                "herramienta_id.required" => "Debe seleccionar una herramienta"
            ]);
            $herramientas = Herramienta::where("id", $herramienta_id)->get();
        }

        $pdf = PDF::loadView('reportes.informacion_herramientas', compact('herramientas'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('informacion_herramientas.pdf');
    }
    public function informe_solicitudes(Request $request)
    {
        $filtro = $request->filtro;
        $ot = $request->ot;
        $equipo = $request->equipo;
        $herramienta = $request->herramienta;

        $orden_trabajos = OrdenTrabajo::select("orden_trabajos.*")
            ->get();
        if ($filtro != "todos") {
            if ($filtro == 'ot') {
                $request->validate([
                    "ot" => "required"
                ], [
                    "ot.required" => "Debes seleccionar una orden de trabajo"
                ]);

                $orden_trabajos = OrdenTrabajo::select("orden_trabajos.*")
                    ->where("id", $ot)
                    ->get();
            }
            if ($filtro == 'equipo') {
                $request->validate([
                    "equipo" => "required"
                ], [
                    "equipo.required" => "Debes seleccionar un equipo"
                ]);

                $orden_trabajos = OrdenTrabajo::select("orden_trabajos.*")
                    ->join("gama_mantenimientos", "gama_mantenimientos.id", "=", "orden_trabajos.gama_id")
                    ->where("gama_mantenimientos.equipo_id", $equipo)
                    ->get();
            }
            if ($filtro == 'herramienta') {
                $request->validate([
                    "herramienta" => "required"
                ], [
                    "herramienta.required" => "Debes seleccionar una herramienta"
                ]);

                $orden_trabajos = OrdenTrabajo::select("orden_trabajos.*")
                    ->join("orden_generadas", "orden_generadas.orden_id", "=", "orden_trabajos.id")
                    ->join("detalle_herramientas", "detalle_herramientas.orden_generada_id", "=", "orden_generadas.id")
                    ->where("detalle_herramientas.herramienta_id", $herramienta)
                    ->get();
            }
        }

        $pdf = PDF::loadView('reportes.informe_solicitudes', compact('orden_trabajos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('informacion_herramientas.pdf');
    }
    public function kardex_repuestos(Request $request)
    {
        $filtro = $request->filtro;
        $repuesto = $request->repuesto;

        if ($request->filtro == 'repuesto') {
            $request->validate([
                'repuesto' => 'required',
            ]);
        }
        $repuestos = Repuesto::all();
        if ($filtro != 'todos') {
            if ($filtro == 'repuesto') {
                $repuestos = Repuesto::where("id", $repuesto)->get();
            }
        }

        $array_kardex = [];
        $array_saldo_anterior = [];
        foreach ($repuestos as $registro) {
            $kardex = KardexRepuesto::where('repuesto_id', $registro->id)->get();
            $array_saldo_anterior[$registro->id] = [
                'sw' => false,
                'saldo_anterior' => []
            ];
            $array_kardex[$registro->id] = $kardex;
        }

        $pdf = PDF::loadView('reportes.kardex_repuestos', compact('repuestos', 'array_kardex', 'array_saldo_anterior'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('kardex_repuestos.pdf');
    }
    public function entrada_salida_repuestos(Request $request)
    {
        $filtro = $request->filtro;
        $repuesto = $request->repuesto;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        if ($request->filtro == 'repuesto') {
            $request->validate([
                'repuesto' => 'required',
            ]);
        }
        if ($request->filtro == 'fecha') {
            $request->validate([
                'fecha_ini' => 'required|date',
                'fecha_fin' => 'required|date',
            ]);
        }

        $repuestos = Repuesto::all();
        if ($filtro != 'todos') {
            if ($filtro == 'repuesto') {
                $repuestos = Repuesto::where("id", $repuesto)->get();
            }
        }

        $array_kardex = [];
        $array_saldo_anterior = [];
        foreach ($repuestos as $registro) {
            $kardex = KardexRepuesto::where('repuesto_id', $registro->id)->get();
            $array_saldo_anterior[$registro->id] = [
                'sw' => false,
                'saldo_anterior' => []
            ];
            if ($filtro == 'fecha') {
                $kardex = KardexRepuesto::where('repuesto_id', $registro->id)
                    ->whereBetween('fecha', [$fecha_ini, $fecha_fin])->get();
                // buscar saldo anterior si existe
                $saldo_anterior = KardexRepuesto::where('repuesto_id', $registro->id)
                    ->where('fecha', '<', $fecha_ini)
                    ->orderBy('created_at', 'asc')->get()->last();
                if ($saldo_anterior) {
                    $cantidad_saldo = $saldo_anterior->cantidad_saldo;
                    $monto_saldo = $saldo_anterior->monto_saldo;
                    $array_saldo_anterior[$registro->id] = [
                        'sw' => true,
                        'saldo_anterior' => [
                            'cantidad_saldo' => $cantidad_saldo,
                            'monto_saldo' => $monto_saldo,
                        ]
                    ];
                }
            }
            $array_kardex[$registro->id] = $kardex;
        }

        $pdf = PDF::loadView('reportes.entrada_salida_repuestos', compact('repuestos', 'array_kardex', 'array_saldo_anterior'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('entrada_salida_repuestos.pdf');
    }

    public function plan_mantenimiento(Request $request)
    {
        $filtro = $request->filtro;
        $estado = $request->estado;

        $plan_mantenimientos = PlanMantenimiento::all();
        if ($filtro != "todos") {
            $request->validate([
                "estado" => "required"
            ]);
            $plan_mantenimientos = PlanMantenimiento::where("estado", $estado)->get();
        }

        $pdf = PDF::loadView('reportes.plan_mantenimiento', compact("plan_mantenimientos"))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('plan_mantenimiento.pdf');
    }
    public function maestro_plan_mantenimiento(Request $request)
    {
        $filtro = $request->filtro;
        $equipo = $request->equipo;
        $anio = $request->anio;
        $mes = $request->mes;
        $registros = [];

        if ($filtro != "todos") {
            if ($filtro == "equipo") {
                $request->validate([
                    "equipo" => "required"
                ]);
                $anios = OrdenTrabajo::getAniosOT();
                $meses = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
                $registros = [];
                $index_dias_mes = [];
                foreach ($anios as $anio) {
                    foreach ($meses as $mes) {
                        $dias_mes = OrdenTrabajo::obtenerDiasMes($anio, $mes);
                        $index_dias_mes[$anio][$mes] = $dias_mes;
                        foreach ($dias_mes as $dm) {
                            $registros[$anio][$mes][$dm] = [];
                            $fecha = $anio . '-' . $mes . '-' . ($dm < 10 ? '0' . $dm : $dm);
                            $ots = OrdenTrabajo::select("orden_trabajos.id", "orden_trabajos.estado")
                                ->join("gama_mantenimientos", "gama_mantenimientos.id", "=", "orden_trabajos.gama_id")
                                ->where("gama_mantenimientos.equipo_id", $equipo)
                                ->where("fecha_programada", $fecha)->get();
                            if (count($ots) > 0) {
                                $registros[$anio][$mes][$dm] = $ots;
                            }
                        }
                    }
                }
            }
            if ($filtro == "anio_mes") {
                $request->validate([
                    "anio" => "required",
                    "mes" => "required"
                ]);
                $anios = [$anio];
                $meses = [$mes];
                $registros = [];
                $index_dias_mes = [];
                foreach ($anios as $anio) {
                    foreach ($meses as $mes) {
                        $dias_mes = OrdenTrabajo::obtenerDiasMes($anio, $mes);
                        $index_dias_mes[$anio][$mes] = $dias_mes;
                        foreach ($dias_mes as $dm) {
                            $registros[$anio][$mes][$dm] = [];
                            $fecha = $anio . '-' . $mes . '-' . ($dm < 10 ? '0' . $dm : $dm);
                            $ots = OrdenTrabajo::select("id", "estado")
                                ->where("fecha_programada", $fecha)->get();
                            if (count($ots) > 0) {
                                $registros[$anio][$mes][$dm] = $ots;
                            }
                        }
                    }
                }
            }
        } else {
            $anios = OrdenTrabajo::getAniosOT();
            $meses = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
            $registros = [];
            $index_dias_mes = [];
            foreach ($anios as $anio) {
                foreach ($meses as $mes) {
                    $dias_mes = OrdenTrabajo::obtenerDiasMes($anio, $mes);
                    $index_dias_mes[$anio][$mes] = $dias_mes;
                    foreach ($dias_mes as $dm) {
                        $registros[$anio][$mes][$dm] = [];
                        $fecha = $anio . '-' . $mes . '-' . ($dm < 10 ? '0' . $dm : $dm);
                        $ots = OrdenTrabajo::select("id", "estado")->where("fecha_programada", $fecha)->get();
                        if (count($ots) > 0) {
                            $registros[$anio][$mes][$dm] = $ots;
                        }
                    }
                }
            }
        }

        $pdf = PDF::loadView('reportes.maestro_plan_mantenimiento', compact("anios", "meses", "index_dias_mes", "registros"))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('maestro_plan_mantenimiento.pdf');
    }
    public function historial_fallas(Request $request)
    {
        $filtro = $request->filtro;
        $equipo = $request->equipo;
        $anio = $request->anio;
        $mes = $request->mes;
        $registros = [];

        $historial_fallas = HistorialFalla::orderBy("fecha_falla", "asc")->get();
        if ($filtro != "todos") {
            if ($filtro == "equipo") {
                $historial_fallas = HistorialFalla::orderBy("fecha_falla", "asc")
                    ->where("equipo_id", $equipo)->get();
            }
            if ($filtro == "anio_mes") {
                $historial_fallas = HistorialFalla::orderBy("fecha_falla", "asc")
                    ->where("fecha_falla", "LIKE", "$anio-$mes%")->get();
            }
        }

        $pdf = PDF::loadView('reportes.historial_fallas', compact("historial_fallas"))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('historial_fallas.pdf');
    }
    public function seguimiento_costos(Request $request)
    {
    }
    public function informe_general(Request $request)
    {
    }
    public function informe_ot_correctivas(Request $request)
    {
    }
    public function resumen_ots(Request $request)
    {
    }
    public function grafico_ots(Request $request)
    {
    }


    public function grafico_ingresos(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $filtro =  $request->filtro;
        $producto_id =  $request->producto_id;

        if ($filtro == 'Producto') {
            $productos = Producto::select("productos.*")
                ->where("id", $producto_id)
                ->get();
        } else {
            $productos = Producto::select("productos.*")
                ->whereExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('detalle_ventas')
                        ->whereRaw('productos.id = detalle_ventas.producto_id');
                })
                ->get();
        }
        $data = [];
        foreach ($productos as $producto) {
            $cantidad = 0;
            if ($filtro == 'Rango de fechas') {
                $cantidad = DetalleOrden::select("detalle_ventas")
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.estado", "CANCELADO")
                    ->where("detalle_ventas.producto_id", $producto->id)
                    ->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])
                    ->sum("detalle_ventas.subtotal");
            } else {
                $cantidad = DetalleOrden::where("producto_id", $producto->id)
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.estado", "CANCELADO")
                    ->sum("subtotal");
            }
            $data[] = [$producto->nombre, $cantidad ? (float)$cantidad : 0];
        }

        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "datos" => $data,
            "fecha" => $fecha
        ]);
    }
}
