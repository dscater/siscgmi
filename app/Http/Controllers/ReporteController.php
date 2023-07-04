<?php

namespace App\Http\Controllers;

use App\Models\DetalleOrden;
use App\Models\Herramienta;
use App\Models\HistorialAccion;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Models\User;
use App\Models\Venta;
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
    public function inform_solicitudes(Request $request)
    {
    }
    public function kardex_repuestos(Request $request)
    {
        $filtro = $request->filtro;
        $producto_id = $request->producto_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        if ($request->filtro == 'Producto') {
            $request->validate([
                'producto_id' => 'required',
            ]);
        }

        if ($request->filtro == 'Rango de fechas') {
            $request->validate([
                'fecha_ini' => 'required|date',
                'fecha_fin' => 'required|date',
            ]);
        }

        $productos = Producto::all();
        if ($filtro != 'todos') {
            if ($filtro == 'Producto') {
                $productos = Producto::where("id", $producto_id)->get();
            }
        }

        $array_kardex = [];
        $array_saldo_anterior = [];
        foreach ($productos as $registro) {
            $kardex = KardexProducto::where('producto_id', $registro->id)->get();
            $array_saldo_anterior[$registro->id] = [
                'sw' => false,
                'saldo_anterior' => []
            ];
            if ($filtro == 'Rango de fechas') {
                $kardex = KardexProducto::where('producto_id', $registro->id)
                    ->whereBetween('fecha', [$fecha_ini, $fecha_fin])->get();
                // buscar saldo anterior si existe
                $saldo_anterior = KardexProducto::where('producto_id', $registro->id)
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

        $pdf = PDF::loadView('reportes.kardex', compact('productos', 'array_kardex', 'array_saldo_anterior'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->setOption('footer-right', '[page]');

        return $pdf->stream('kardex.pdf');
    }
    public function entrada_salida_repuestos(Request $request)
    {
    }
    public function plan_mantenimiento(Request $request)
    {
    }
    public function maestro_plan_mantenimiento(Request $request)
    {
    }
    public function historial_fallas(Request $request)
    {
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
